<?php
$content = file_get_contents('app/Core/Router.php');
$search = <<<'SEARCH'
    private function normalisedUri(): string
    {
        $uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH) ?? '/';

        // Strip language prefix: /en/, /de/ → store lang, continue without prefix
SEARCH;

$replace = <<<'REPLACE'
    private function normalisedUri(): string
    {
        $uri = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?? '/';
        $scriptDir = dirname($_SERVER['SCRIPT_NAME'] ?? '');

        if ($scriptDir !== '/' && $scriptDir !== '\\' && str_starts_with($uri, $scriptDir)) {
            $uri = substr($uri, strlen($scriptDir));
        }

        // Strip language prefix: /en/, /de/ → store lang, continue without prefix
REPLACE;

$content = str_replace($search, $replace, $content);
file_put_contents('app/Core/Router.php', $content);
echo "Fixed Router XAMPP base path\n";
