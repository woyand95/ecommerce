<?php
$request_uri = '/ecommerce/public/de/products/rotes-t-shirt';
$script_name = '/ecommerce/public/index.php';

$path = parse_url($request_uri, PHP_URL_PATH);
$scriptDir = dirname($script_name);

if (str_starts_with($path, $scriptDir)) {
    $path = substr($path, strlen($scriptDir));
}

echo $path . "\n";
