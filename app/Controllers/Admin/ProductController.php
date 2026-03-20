<?php

namespace App\Controllers\Admin;

use App\Core\Controller;
use App\Models\Product;
use App\Models\Branch;
use App\Services\FileUploadService;
use App\Services\CacheService;

/**
 * Admin\ProductController — CRUD for products (centralized, all branches).
 * Middleware: ['auth', 'admin']
 */
class ProductController extends Controller
{
    public function __construct(
        private readonly Product           $productModel   = new Product(),
        private readonly Branch            $branchModel    = new Branch(),
        private readonly FileUploadService $uploadService  = new FileUploadService(),
        private readonly CacheService      $cache          = new CacheService(),
    ) {
        parent::__construct('backend');
    }

    /** GET /admin/products */
    public function index(array $params = []): void
    {
        $page    = (int) $this->request->query('page', 1);
        $search  = $this->request->query('search', '');
        $filters = array_filter(['is_active' => $this->request->query('status', '')]);

        // Admin superadmin sees all; branch_manager sees only their branch
        $adminBranchId = $this->adminUser()['branch_id'] ?? null;

        $result = $this->productModel->paginate($page, 25, $filters);

        $this->view('pages/products/index', [
            'products'   => $result['data'],
            'pagination' => $result,
            'search'     => $search,
            'branches'   => $this->branchModel->all(['is_active' => 1]),
            'title'      => 'Product Management',
        ]);
    }

    /** GET /admin/products/create */
    public function create(array $params = []): void
    {
        $this->view('pages/products/form', [
            'product'  => null,
            'branches' => $this->branchModel->all(['is_active' => 1]),
            'title'    => 'Add New Product',
        ]);
    }

    /** POST /admin/products */
    public function store(array $params = []): void
    {
        $data = $this->validate($this->request->all(), [
            'sku'         => 'required|unique:products,sku',
            'category_id' => 'nullable|integer',
            'type'        => 'required|in:simple,variable,bundle',
            'translations' => 'required|array',
            'branch_prices' => 'required|array',
        ]);

        try {
            $productId = $this->productModel->create([
                'sku'         => $data['sku'],
                'category_id' => $data['category_id'] ?? null,
                'type'        => $data['type'],
                'weight'      => $data['weight'] ?? null,
                'is_active'   => $data['is_active'] ?? 0,
                'is_featured' => $data['is_featured'] ?? 0,
            ]);

            // Store translations
            foreach ($data['translations'] as $lang => $translation) {
                $this->db->insert('product_translations', array_merge($translation, [
                    'product_id' => $productId,
                    'lang_code'  => $lang,
                    'url_slug'   => $this->generateSlug($translation['name']),
                ]));
            }

            // Store branch prices
            foreach ($data['branch_prices'] as $branchId => $prices) {
                foreach ($prices as $priceGroup => $priceData) {
                    if (empty($priceData['price'])) continue;
                    $this->db->insert('product_branch_prices', [
                        'product_id'  => $productId,
                        'branch_id'   => $branchId,
                        'price_group' => $priceGroup,
                        'price'       => $priceData['price'],
                        'sale_price'  => $priceData['sale_price'] ?? null,
                    ]);
                }
            }

            // Store branch stock
            foreach (($data['branch_stock'] ?? []) as $branchId => $stockData) {
                $this->db->insert('product_branch_stock', [
                    'product_id'     => $productId,
                    'branch_id'      => $branchId,
                    'quantity'       => $stockData['quantity'] ?? 0,
                    'allow_backorder'=> $stockData['allow_backorder'] ?? 0,
                    'track_stock'    => $stockData['track_stock'] ?? 1,
                ]);
            }

            // Handle image uploads
            if ($this->request->hasFile('images')) {
                $this->handleImageUploads($productId, $this->request->files('images'));
            }

            // Bust product cache
            $this->cache->forget("products:*");

            $this->flash('success', 'Product created successfully.');
            $this->redirect("/admin/products/$productId/edit");

        } catch (\Exception $e) {
            $this->flash('error', $e->getMessage());
            $this->redirect('/admin/products/create');
        }
    }

    /** GET /admin/products/{id}/edit */
    public function edit(array $params): void
    {
        $product = $this->productModel->findOrFail((int) $params['id']);

        // Load all translations
        $translations = $this->db->fetchAll(
            "SELECT * FROM product_translations WHERE product_id = ?",
            [$product['id']]
        );

        // Load branch prices (all branches × price groups)
        $prices = $this->db->fetchAll(
            "SELECT * FROM product_branch_prices WHERE product_id = ?",
            [$product['id']]
        );

        // Load branch stock
        $stock = $this->db->fetchAll(
            "SELECT * FROM product_branch_stock WHERE product_id = ?",
            [$product['id']]
        );

        // Load images
        $images = $this->db->fetchAll(
            "SELECT * FROM product_images WHERE product_id = ? ORDER BY sort_order",
            [$product['id']]
        );

        $this->view('pages/products/form', [
            'product'      => $product,
            'translations' => array_column($translations, null, 'lang_code'),
            'prices'       => $this->indexByBranchAndGroup($prices),
            'stock'        => array_column($stock, null, 'branch_id'),
            'images'       => $images,
            'branches'     => $this->branchModel->all(['is_active' => 1]),
            'title'        => 'Edit: ' . ($translations[0]['name'] ?? $product['sku']),
        ]);
    }

    /** PATCH /admin/products/{id} */
    public function update(array $params): void
    {
        $id   = (int) $params['id'];
        $data = $this->request->all();

        $this->productModel->update($id, array_intersect_key($data, array_flip([
            'category_id', 'type', 'weight', 'width', 'height', 'depth',
            'is_active', 'is_featured', 'sort_order',
        ])));

        // Update translations
        foreach (($data['translations'] ?? []) as $lang => $translation) {
            $existing = $this->db->fetchOne(
                "SELECT id FROM product_translations WHERE product_id=? AND lang_code=?",
                [$id, $lang]
            );
            if ($existing) {
                $this->db->update('product_translations', $translation, ['id' => $existing['id']]);
            } else {
                $this->db->insert('product_translations', array_merge($translation, [
                    'product_id' => $id, 'lang_code' => $lang,
                ]));
            }
        }

        // Upsert branch prices
        foreach (($data['branch_prices'] ?? []) as $branchId => $groups) {
            foreach ($groups as $group => $priceData) {
                $this->db->execute(
                    "INSERT INTO product_branch_prices
                        (product_id, branch_id, price_group, price, sale_price, sale_from, sale_until)
                     VALUES (?, ?, ?, ?, ?, ?, ?)
                     ON DUPLICATE KEY UPDATE
                        price=VALUES(price), sale_price=VALUES(sale_price),
                        sale_from=VALUES(sale_from), sale_until=VALUES(sale_until)",
                    [
                        $id, $branchId, $group,
                        $priceData['price'],
                        $priceData['sale_price'] ?? null,
                        $priceData['sale_from']  ?? null,
                        $priceData['sale_until'] ?? null,
                    ]
                );
            }
        }

        // Upsert stock
        foreach (($data['branch_stock'] ?? []) as $branchId => $stockData) {
            $this->db->execute(
                "INSERT INTO product_branch_stock
                    (product_id, branch_id, quantity, allow_backorder, track_stock)
                 VALUES (?, ?, ?, ?, ?)
                 ON DUPLICATE KEY UPDATE
                    quantity=VALUES(quantity), allow_backorder=VALUES(allow_backorder),
                    track_stock=VALUES(track_stock)",
                [$id, $branchId, $stockData['quantity'] ?? 0, $stockData['allow_backorder'] ?? 0, $stockData['track_stock'] ?? 1]
            );
        }

        $this->cache->forget("products:*");
        $this->flash('success', 'Product updated.');
        $this->redirect("/admin/products/$id/edit");
    }

    /** DELETE /admin/products/{id} */
    public function destroy(array $params): void
    {
        $this->productModel->delete((int) $params['id']);
        $this->cache->forget("products:*");
        $this->flash('success', 'Product deleted.');
        $this->redirect('/admin/products');
    }

    // ── Private helpers ──────────────────────────────────────

    private function handleImageUploads(int $productId, array $files): void
    {
        $isPrimary = true;
        foreach ($files as $file) {
            $path = $this->uploadService->store($file, 'products/' . $productId);
            $this->db->insert('product_images', [
                'product_id' => $productId,
                'file_path'  => $path,
                'is_primary' => (int) $isPrimary,
                'sort_order' => 0,
            ]);
            $isPrimary = false;
        }
    }

    private function generateSlug(string $name): string
    {
        $slug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $name), '-'));
        $base = $slug;
        $i    = 1;
        while ($this->db->fetchOne("SELECT id FROM product_translations WHERE url_slug=?", [$slug])) {
            $slug = "$base-" . $i++;
        }
        return $slug;
    }

    private function indexByBranchAndGroup(array $prices): array
    {
        $result = [];
        foreach ($prices as $price) {
            $result[$price['branch_id']][$price['price_group']] = $price;
        }
        return $result;
    }
}
