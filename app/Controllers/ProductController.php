<?php

namespace App\Controllers;

use App\Core\Controller;
use App\Models\Product;
use App\Models\Category;
use App\Services\BranchService;

/**
 * ProductController — storefront product listing and detail pages.
 */
class ProductController extends Controller
{
    public function __construct(
        private readonly Product  $productModel  = new Product(),
        private readonly Category $categoryModel = new Category(),
    ) {
        parent::__construct();
    }

    /**
     * GET /products  or  GET /category/{slug}
     */
    public function index(array $params = []): void
    {
        $branch     = BranchService::getCurrent();
        $lang       = $this->lang();
        $priceGroup = $this->customer()?['price_group'] ?? 'standard';

        $page    = max(1, (int) $this->request->query('page', 1));
        $perPage = 24;
        $offset  = ($page - 1) * $perPage;

        // Optional category filter
        $categorySlug = $params['slug'] ?? null;
        $category     = null;

        if ($categorySlug) {
            $category = $this->categoryModel->findBySlug($categorySlug, $lang);
            if (!$category) {
                $this->abort(404, 'Category not found');
                return;
            }
        }

        $products = $this->productModel->getForBranch(
            $branch['id'], $lang, $priceGroup, $perPage, $offset
        );

        $this->view('pages/products', [
            'products'       => $products,
            'category'       => $category,
            'categories'     => $this->categoryModel->getTree($lang),
            'page'           => $page,
            'per_page'       => $perPage,
            'meta_title'     => $category['name'] ?? __('shop.all_products'),
            'meta_description' => $category['meta_description'] ?? '',
        ]);
    }

    /**
     * GET /products/{slug}
     */
    public function show(array $params): void
    {
        $branch     = BranchService::getCurrent();
        $lang       = $this->lang();
        $priceGroup = $this->customer()?['price_group'] ?? 'standard';

        $product = $this->productModel->findBySlug($params['slug'], $branch['id'], $lang);

        if (!$product) {
            $this->abort(404, 'Product not found');
            return;
        }

        $related = $this->productModel->getForBranch(
            $branch['id'], $lang, $priceGroup, 4, 0
        );

        $this->view('pages/product-detail', [
            'product'          => $product,
            'related_products' => $related,
            'meta_title'       => $product['meta_title'] ?: $product['name'],
            'meta_description' => $product['meta_description'] ?? '',
            'structured_data'  => $this->buildProductSchema($product, $branch),
        ]);
    }

    /**
     * GET /search?q=query
     */
    public function search(array $params = []): void
    {
        $query  = strip_tags($this->request->query('q', ''));
        $branch = BranchService::getCurrent();
        $lang   = $this->lang();

        $results = $query
            ? $this->productModel->search($query, $branch['id'], $lang)
            : [];

        $this->view('pages/search', [
            'query'      => $query,
            'products'   => $results,
            'meta_title' => sprintf(__('shop.search_results_for'), $query),
        ]);
    }

    // ── Private ──────────────────────────────────────────────

    private function buildProductSchema(array $product, array $branch): array
    {
        return [
            '@context' => 'https://schema.org',
            '@type'    => 'Product',
            'name'     => $product['name'],
            'sku'      => $product['sku'],
            'offers'   => [
                '@type'         => 'Offer',
                'price'         => $product['price'],
                'priceCurrency' => $branch['currency_code'],
                'availability'  => $product['stock_qty'] > 0
                    ? 'https://schema.org/InStock'
                    : 'https://schema.org/OutOfStock',
            ],
        ];
    }
}
