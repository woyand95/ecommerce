<?php

namespace App\Controllers\Admin;

use App\Core\Controller;
use App\Core\Database;

/**
 * Admin\PageController — CMS / Page Builder.
 *
 * Supports: create/edit pages, manage content blocks per-language,
 * SEO settings, and template assignment.
 */
class PageController extends Controller
{
    private Database $db;

    public function __construct()
    {
        parent::__construct('backend');
        $this->db = Database::getInstance();
    }

    /** GET /admin/pages */
    public function index(array $params = []): void
    {
        $branchId = $this->adminBranchId(); // null for superadmin = show all

        $sql    = "SELECT p.*, pt.title, pt.url_slug
                   FROM pages p
                   LEFT JOIN page_translations pt ON pt.page_id=p.id AND pt.lang_code='de'";
        $dbParams = [];

        if ($branchId) {
            $sql     .= ' WHERE p.branch_id = ?';
            $dbParams = [$branchId];
        }
        $sql .= ' ORDER BY p.sort_order, p.created_at DESC';

        $this->view('pages/cms/index', [
            'pages' => $this->db->fetchAll($sql, $dbParams),
            'title' => 'Pages',
        ]);
    }

    /** GET /admin/pages/create */
    public function create(array $params = []): void
    {
        $this->view('pages/cms/builder', [
            'page'        => null,
            'translations'=> [],
            'blocks'      => [],
            'branches'    => $this->db->fetchAll("SELECT id, name FROM branches WHERE is_active=1"),
            'templates'   => $this->getPageTemplates(),
            'block_types' => $this->getBlockTypes(),
            'title'       => 'New Page',
        ]);
    }

    /** POST /admin/pages */
    public function store(array $params = []): void
    {
        $data = $this->request->all();

        $pageId = $this->db->insert('pages', [
            'branch_id'   => $data['branch_id'] ?: null,
            'template'    => $data['template']   ?? 'standard',
            'status'      => $data['status']      ?? 'draft',
            'show_in_nav' => (int) ($data['show_in_nav'] ?? 0),
            'created_by'  => $this->adminUser()['id'],
            'created_at'  => date('Y-m-d H:i:s'),
        ]);

        $this->storeTranslations((int) $pageId, $data['translations'] ?? []);
        $this->storeBlocks((int) $pageId, $data['blocks'] ?? []);

        $this->flash('success', 'Page created.');
        $this->redirect("/admin/pages/$pageId/edit");
    }

    /** GET /admin/pages/{id}/edit */
    public function edit(array $params): void
    {
        $page = $this->db->fetchOne("SELECT * FROM pages WHERE id=?", [(int) $params['id']]);
        if (!$page) $this->abort(404);

        $translations = $this->db->fetchAll(
            "SELECT * FROM page_translations WHERE page_id=?", [$page['id']]
        );

        // Blocks with per-language content
        $blocks = $this->db->fetchAll(
            "SELECT pb.*, GROUP_CONCAT(pbt.lang_code) as langs
             FROM page_blocks pb
             LEFT JOIN page_block_translations pbt ON pbt.block_id=pb.id
             WHERE pb.page_id=?
             GROUP BY pb.id
             ORDER BY pb.sort_order",
            [$page['id']]
        );

        foreach ($blocks as &$block) {
            $block['content'] = $this->db->fetchAll(
                "SELECT * FROM page_block_translations WHERE block_id=?", [$block['id']]
            );
        }

        $this->view('pages/cms/builder', [
            'page'         => $page,
            'translations' => array_column($translations, null, 'lang_code'),
            'blocks'       => $blocks,
            'branches'     => $this->db->fetchAll("SELECT id, name FROM branches WHERE is_active=1"),
            'templates'    => $this->getPageTemplates(),
            'block_types'  => $this->getBlockTypes(),
            'title'        => 'Edit: ' . ($translations[0]['title'] ?? '#' . $page['id']),
        ]);
    }

    /** PATCH /admin/pages/{id} */
    public function update(array $params): void
    {
        $id   = (int) $params['id'];
        $data = $this->request->all();

        $this->db->update('pages', [
            'template'    => $data['template'],
            'status'      => $data['status'],
            'show_in_nav' => (int) ($data['show_in_nav'] ?? 0),
            'updated_at'  => date('Y-m-d H:i:s'),
        ], ['id' => $id]);

        $this->storeTranslations($id, $data['translations'] ?? [], true);
        $this->storeBlocks($id, $data['blocks'] ?? [], true);

        $this->flash('success', 'Page saved.');
        $this->redirect("/admin/pages/$id/edit");
    }

    // ── Block helpers ─────────────────────────────────────────

    private function storeTranslations(int $pageId, array $translations, bool $upsert = false): void
    {
        foreach ($translations as $lang => $trans) {
            if ($upsert) {
                $existing = $this->db->fetchOne(
                    "SELECT id FROM page_translations WHERE page_id=? AND lang_code=?",
                    [$pageId, $lang]
                );
                if ($existing) {
                    $this->db->update('page_translations', array_merge($trans, [
                        'url_slug' => $this->uniquePageSlug($trans['url_slug'] ?? '', $pageId, $lang),
                    ]), ['id' => $existing['id']]);
                    continue;
                }
            }
            $this->db->insert('page_translations', array_merge($trans, [
                'page_id'  => $pageId,
                'lang_code'=> $lang,
                'url_slug' => $this->uniquePageSlug($trans['url_slug'] ?? '', $pageId, $lang),
            ]));
        }
    }

    private function storeBlocks(int $pageId, array $blocks, bool $replacing = false): void
    {
        if ($replacing) {
            $this->db->execute("DELETE FROM page_blocks WHERE page_id=?", [$pageId]);
        }

        foreach ($blocks as $index => $block) {
            $blockId = $this->db->insert('page_blocks', [
                'page_id'    => $pageId,
                'block_type' => $block['type'],
                'sort_order' => $index,
                'css_class'  => $block['css_class'] ?? null,
                'settings'   => json_encode($block['settings'] ?? []),
                'is_active'  => (int) ($block['is_active'] ?? 1),
            ]);

            foreach ($block['content'] ?? [] as $lang => $content) {
                $this->db->insert('page_block_translations', [
                    'block_id'  => $blockId,
                    'lang_code' => $lang,
                    'content'   => is_array($content) ? json_encode($content) : $content,
                ]);
            }
        }
    }

    private function uniquePageSlug(string $slug, int $pageId, string $lang): string
    {
        $slug = $slug ?: 'page-' . $pageId;
        $base = $slug;
        $i    = 1;
        while ($this->db->fetchOne(
            "SELECT id FROM page_translations WHERE url_slug=? AND lang_code=? AND page_id!=?",
            [$slug, $lang, $pageId]
        )) {
            $slug = "$base-" . $i++;
        }
        return $slug;
    }

    private function getPageTemplates(): array
    {
        return [
            'standard'   => 'Standard Page',
            'landing'    => 'Landing Page',
            'full_width' => 'Full Width',
            'sidebar'    => 'With Sidebar',
        ];
    }

    private function getBlockTypes(): array
    {
        return [
            'text'       => ['icon' => 'type',       'label' => 'Text / Rich Text'],
            'image'      => ['icon' => 'image',       'label' => 'Image'],
            'slider'     => ['icon' => 'layout',      'label' => 'Image Slider'],
            'html'       => ['icon' => 'code',        'label' => 'Custom HTML'],
            'cta'        => ['icon' => 'zap',         'label' => 'Call to Action'],
            'grid'       => ['icon' => 'grid',        'label' => 'Image + Text Grid'],
            'products'   => ['icon' => 'shopping-bag','label' => 'Product Showcase'],
            'faq'        => ['icon' => 'help-circle', 'label' => 'FAQ Accordion'],
            'spacer'     => ['icon' => 'minus',       'label' => 'Spacer'],
        ];
    }
}
