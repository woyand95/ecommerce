<?php

namespace App\Controllers;

use App\Core\Controller;
use App\Models\Product;
use App\Services\BranchService;

class HomeController extends Controller {
    public function index(array $params = []): void {
        $branch     = BranchService::getCurrent();
        $lang       = $this->lang();
        $priceGroup = $this->customer()['price_group'] ?? 'standard';

        try {
            $productModel = new Product();
            $featured  = $productModel->getForBranch($branch['id'], $lang, $priceGroup, 8, 0);
        } catch (\Throwable) {
            $featured = [];
        }

        $this->view('pages/home', [
            'featured_products' => $featured,
            'branch'            => $branch,
            'meta_title'        => 'TechStore – Ihr Elektronik-Fachhandel',
            'meta_description'  => 'Smartphones, Laptops, Audio & Smart Home. Günstig kaufen & schnell geliefert.',
        ]);
    }
}
