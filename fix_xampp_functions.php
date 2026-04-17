<?php
$content = file_get_contents('app/Helpers/functions.php');
$search = <<<'SEARCH'
    $base = rtrim(config('app.url'), '/');
    $path = '/' . ltrim($path, '/');
SEARCH;

$replace = <<<'REPLACE'
    $base = rtrim(config('app.url'), '/');
    $scriptDir = dirname($_SERVER['SCRIPT_NAME'] ?? '');
    if ($scriptDir !== '/' && $scriptDir !== '\\') {
        $base .= $scriptDir;
    }
    $path = '/' . ltrim($path, '/');
REPLACE;

$content = str_replace($search, $replace, $content);

$searchAsset = <<<'SEARCH'
    $v = defined('APP_VERSION') ? '?v=' . APP_VERSION : '';
    return '/assets/' . ltrim($path, '/') . $v;
SEARCH;

$replaceAsset = <<<'REPLACE'
    $v = defined('APP_VERSION') ? '?v=' . APP_VERSION : '';
    $scriptDir = dirname($_SERVER['SCRIPT_NAME'] ?? '');
    $base = ($scriptDir !== '/' && $scriptDir !== '\\') ? $scriptDir : '';
    return rtrim($base, '/') . '/assets/' . ltrim($path, '/') . $v;
REPLACE;

$content = str_replace($searchAsset, $replaceAsset, $content);
file_put_contents('app/Helpers/functions.php', $content);
echo "Fixed Helpers XAMPP base path\n";
