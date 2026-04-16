<?php

namespace App\Controllers\Admin;

use App\Core\Controller;

class CategoryController extends Controller {
    
    public function __construct(string $scope = 'backend') {
        parent::__construct($scope);
        
        if (!$this->adminUser()) {
            session_flash('error', 'Bitte melden Sie sich als Administrator an.');
            $this->redirect('/admin/login');
        }
    }

    public function index(array $p = []): void {
        $categories = $this->db->fetchAll("
            SELECT c.*, 
                   COALESCE(ct.name, ct2.name) as name,
                   COUNT(p.id) as product_count
            FROM categories c
            LEFT JOIN category_translations ct ON ct.category_id = c.id AND ct.lang_code = 'de'
            LEFT JOIN category_translations ct2 ON ct2.category_id = c.id AND ct2.lang_code = 'de'
            LEFT JOIN products p ON p.category_id = c.id AND p.is_active = 1
            GROUP BY c.id
            ORDER BY c.parent_id, c.sort_order
        ");
        
        $this->view('admin/categories/index', [
            'title' => 'Kategorien',
            'categories' => $categories
        ]);
    }

    public function create(array $p = []): void {
        $parentCategories = $this->db->fetchAll(
            "SELECT id, name FROM categories WHERE is_active = 1 ORDER BY name"
        );
        
        $this->view('admin/categories/create', [
            'title' => 'Kategorie erstellen',
            'parent_categories' => $parentCategories,
            'csrf_token' => \App\Core\Csrf::token()
        ]);
    }

    public function store(array $p = []): void {
        $data = $this->request->all();
        
        try {
            $this->db->beginTransaction();
            
            // Create category
            $this->db->execute("
                INSERT INTO categories (
                    parent_id, slug, image_url, is_active, sort_order,
                    created_at, updated_at
                ) VALUES (?, ?, ?, ?, ?, NOW(), NOW())
            ", [
                $data['parent_id'] ?? null,
                $data['slug'] ?? '',
                $data['image_url'] ?? null,
                !empty($data['is_active']) ? 1 : 0,
                $data['sort_order'] ?? 0
            ]);
            
            $categoryId = $this->db->lastInsertId();
            
            // Create translations
            $languages = $this->db->fetchAll("SELECT code FROM languages WHERE is_active = 1");
            foreach ($languages as $lang) {
                $name = $data['name_' . $lang['code']] ?? $data['name_de'] ?? '';
                $slug = $data['url_slug_' . $lang['code']] ?? $data['url_slug_de'] ?? '';
                $description = $data['description_' . $lang['code']] ?? $data['description_de'] ?? '';
                
                $this->db->execute("
                    INSERT INTO category_translations (
                        category_id, lang_code, name, url_slug, description, created_at
                    ) VALUES (?, ?, ?, ?, ?, NOW())
                ", [$categoryId, $lang['code'], $name, $slug, $description]);
            }
            
            $this->db->commit();
            
            session_flash('success', 'Kategorie erfolgreich erstellt.');
            $this->redirect('/admin/categories');
            
        } catch (\Throwable $e) {
            $this->db->rollBack();
            error_log("Create category error: " . $e->getMessage());
            session_flash('error', 'Ein Fehler ist aufgetreten: ' . $e->getMessage());
            $this->redirect('/admin/categories/create');
        }
    }

    public function show(array $p = []): void {
        $id = (int) ($p['id'] ?? 0);
        
        $category = $this->db->fetchOne("SELECT * FROM categories WHERE id = ?", [$id]);
        if (!$category) {
            session_flash('error', 'Kategorie nicht gefunden.');
            $this->redirect('/admin/categories');
            return;
        }
        
        $translations = $this->db->fetchAll(
            "SELECT * FROM category_translations WHERE category_id = ?",
            [$id]
        );
        
        $this->view('admin/categories/show', [
            'title' => 'Kategorie anzeigen',
            'category' => $category,
            'translations' => $translations
        ]);
    }

    public function edit(array $p = []): void {
        $id = (int) ($p['id'] ?? 0);
        
        $category = $this->db->fetchOne("SELECT * FROM categories WHERE id = ?", [$id]);
        if (!$category) {
            session_flash('error', 'Kategorie nicht gefunden.');
            $this->redirect('/admin/categories');
            return;
        }
        
        $parentCategories = $this->db->fetchAll(
            "SELECT id, name FROM categories WHERE is_active = 1 AND id != ? ORDER BY name",
            [$id]
        );
        
        $translations = $this->db->fetchAll(
            "SELECT * FROM category_translations WHERE category_id = ?",
            [$id]
        );
        
        $this->view('admin/categories/edit', [
            'title' => 'Kategorie bearbeiten',
            'category' => $category,
            'parent_categories' => $parentCategories,
            'translations' => $translations,
            'csrf_token' => \App\Core\Csrf::token()
        ]);
    }

    public function update(array $p = []): void {
        $id = (int) ($p['id'] ?? 0);
        $data = $this->request->all();
        
        try {
            $this->db->beginTransaction();
            
            // Update category
            $this->db->execute("
                UPDATE categories SET
                    parent_id = ?, slug = ?, image_url = ?, is_active = ?, sort_order = ?,
                    updated_at = NOW()
                WHERE id = ?
            ", [
                $data['parent_id'] ?? null,
                $data['slug'] ?? '',
                $data['image_url'] ?? null,
                !empty($data['is_active']) ? 1 : 0,
                $data['sort_order'] ?? 0,
                $id
            ]);
            
            // Update translations
            $languages = $this->db->fetchAll("SELECT code FROM languages WHERE is_active = 1");
            foreach ($languages as $lang) {
                $name = $data['name_' . $lang['code']] ?? $data['name_de'] ?? '';
                $slug = $data['url_slug_' . $lang['code']] ?? $data['url_slug_de'] ?? '';
                $description = $data['description_' . $lang['code']] ?? $data['description_de'] ?? '';
                
                $this->db->execute("
                    UPDATE category_translations SET
                        name = ?, url_slug = ?, description = ?
                    WHERE category_id = ? AND lang_code = ?
                ", [$name, $slug, $description, $id, $lang['code']]);
            }
            
            $this->db->commit();
            
            session_flash('success', 'Kategorie erfolgreich aktualisiert.');
            $this->redirect('/admin/categories');
            
        } catch (\Throwable $e) {
            $this->db->rollBack();
            error_log("Update category error: " . $e->getMessage());
            session_flash('error', 'Ein Fehler ist aufgetreten: ' . $e->getMessage());
            $this->redirect('/admin/categories/' . $id . '/edit');
        }
    }

    public function destroy(array $p = []): void {
        $id = (int) ($p['id'] ?? 0);
        
        try {
            // Check if category has products
            $productCount = $this->db->fetchColumn(
                "SELECT COUNT(*) FROM products WHERE category_id = ?",
                [$id]
            );
            
            if ($productCount > 0) {
                session_flash('error', 'Kategorie kann nicht gelöscht werden, da sie noch Produkte enthält.');
                $this->redirect('/admin/categories');
                return;
            }
            
            // Delete translations first
            $this->db->execute("DELETE FROM category_translations WHERE category_id = ?", [$id]);
            
            // Delete category
            $this->db->execute("DELETE FROM categories WHERE id = ?", [$id]);
            
            session_flash('success', 'Kategorie erfolgreich gelöscht.');
            
        } catch (\Throwable $e) {
            error_log("Delete category error: " . $e->getMessage());
            session_flash('error', 'Ein Fehler ist aufgetreten.');
        }
        
        $this->redirect('/admin/categories');
    }
}
