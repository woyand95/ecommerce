<?php

namespace App\Controllers\Api;

use App\Core\Controller;
use App\Models\Product;
use App\Models\Order;
use App\Services\BranchService;

/**
 * Api\V1\ProductController — RESTful JSON API.
 * Authentication: JWT via ApiAuthMiddleware.
 * Branch restriction: BranchMiddleware applied globally to /api routes.
 */
class ProductController extends Controller
{
    public function __construct(
        private readonly Product $productModel = new Product(),
    ) {
        parent::__construct();
    }

    /** GET /api/v1/products */
    public function index(array $params = []): void
    {
        $branch     = BranchService::getCurrent();
        $lang       = $this->request->header('Accept-Language', 'de');
        $priceGroup = $this->apiCustomer()?['price_group'] ?? 'standard';
        $page       = (int) $this->request->query('page', 1);
        $perPage    = min((int) $this->request->query('per_page', 24), 100);
        $offset     = ($page - 1) * $perPage;

        $products = $this->productModel->getForBranch($branch['id'], $lang, $priceGroup, $perPage, $offset);
        $total    = $this->productModel->count(['is_active' => 1]);

        $this->json([
            'data' => $products,
            'meta' => [
                'total'        => $total,
                'per_page'     => $perPage,
                'current_page' => $page,
                'last_page'    => (int) ceil($total / $perPage),
            ],
        ]);
    }

    /** GET /api/v1/products/{id} */
    public function show(array $params): void
    {
        $branch     = BranchService::getCurrent();
        $lang       = $this->request->header('Accept-Language', 'de');
        $priceGroup = $this->apiCustomer()?['price_group'] ?? 'standard';

        $product = $this->productModel->getDetail((int) $params['id'], $branch['id'], $lang, $priceGroup);

        if (!$product) {
            $this->json(['error' => 'Product not found'], 404);
            return;
        }

        $this->json(['data' => $product]);
    }

    /** GET /api/v1/products/search?q= */
    public function search(array $params = []): void
    {
        $query = $this->request->query('q', '');
        if (strlen($query) < 2) {
            $this->json(['data' => [], 'query' => $query]);
            return;
        }

        $branch   = BranchService::getCurrent();
        $lang     = $this->request->header('Accept-Language', 'de');
        $results  = $this->productModel->search($query, $branch['id'], $lang);

        $this->json(['data' => $results, 'query' => $query]);
    }
}
