<?php

/**
 * Global helper functions — available everywhere in the app.
 */

// ── Translation ───────────────────────────────────────────

if (!function_exists('__')) {
function __(string $key, array $replace = []): string
{
    return \App\Core\Lang::getInstance()->get($key, $replace);
}
}

if (!function_exists('__e')) {
function __e(string $key, array $replace = []): string
{
    return htmlspecialchars(__($key, $replace), ENT_QUOTES, 'UTF-8');
}
}

// ── Config ────────────────────────────────────────────────

if (!function_exists('config')) {
function config(string $key, mixed $default = null): mixed
{
    static $config = [];
    [$file, $subKey] = explode('.', $key, 2) + [1 => null];
    if (!isset($config[$file])) {
        $path = CONFIG_PATH . "/$file.php";
        $config[$file] = file_exists($path) ? require $path : [];
    }
    $data = $config[$file];
    if ($subKey === null) return $data ?? $default;
    foreach (explode('.', $subKey) as $part) {
        $data = $data[$part] ?? null;
    }
    return $data ?? $default;
}
}

// ── Money formatting ──────────────────────────────────────

if (!function_exists('format_money')) {
function format_money(float|string $amount, string $currency = 'EUR', string $locale = 'de_DE'): string
{
    $fmt = new NumberFormatter($locale, NumberFormatter::CURRENCY);
    return $fmt->formatCurrency((float) $amount, $currency);
}
}

// ── URLs & Assets ─────────────────────────────────────────

if (!function_exists('asset')) {
function asset(string $path): string
{
    $v = defined('APP_VERSION') ? '?v=' . APP_VERSION : '';
    return '/assets/' . ltrim($path, '/') . $v;
}
}

if (!function_exists('url')) {
function url(string $path, array $query = []): string
{
    $base = rtrim(config('app.url'), '/');
    $path = '/' . ltrim($path, '/');

    // Optional: inject language prefix if not default
    if (isset($_SESSION['lang']) && $_SESSION['lang'] !== 'de') {
        $path = '/' . $_SESSION['lang'] . $path;
    }

    $qs = $query ? '?' . http_build_query($query) : '';
    return $base . $path . $qs;
}
}

if (!function_exists('request_path')) {
function request_path(): string
{
    $uri = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?? '/';
    return preg_replace('#^/[a-z]{2}(/|$)#', '/', $uri);
}
}

// ── Session & Flash ───────────────────────────────────────

if (!function_exists('session_flash')) {
function session_flash(string $key, mixed $value): void
{
    $_SESSION['_flash'][$key] = $value;
}
}

if (!function_exists('session_get_flash')) {
function session_get_flash(string $key): mixed
{
    if (isset($_SESSION['_flash'][$key])) {
        $val = $_SESSION['_flash'][$key];
        unset($_SESSION['_flash'][$key]);
        return $val;
    }
    return null;
}
}

if (!function_exists('old')) {
function old(string $key, mixed $default = ''): mixed
{
    return $_SESSION['_old_input'][$key] ?? $default;
}
}

// ── Utils ─────────────────────────────────────────────────

if (!function_exists('get_client_ip')) {
function get_client_ip(): string
{
    $keys = ['HTTP_CLIENT_IP', 'HTTP_X_FORWARDED_FOR', 'REMOTE_ADDR'];
    foreach ($keys as $key) {
        if (!empty($_SERVER[$key])) {
            $ip = trim(explode(',', $_SERVER[$key])[0]);
            if (filter_var($ip, FILTER_VALIDATE_IP)) return $ip;
        }
    }
    return '0.0.0.0';
}
}

if (!function_exists('generate_uuid')) {
function generate_uuid(): string
{
    $data = random_bytes(16);
    $data[6] = chr(ord($data[6]) & 0x0f | 0x40);
    $data[8] = chr(ord($data[8]) & 0x3f | 0x80);
    return vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($data), 4));
}
}

if (!function_exists('str_slug')) {
function str_slug(string $text): string
{
    $text = preg_replace('~[^\pL\d]+~u', '-', $text);
    $text = iconv('utf-8', 'us-ascii//TRANSLIT', $text);
    $text = preg_replace('~[^-\w]+~', '', $text);
    $text = trim($text, '-');
    $text = preg_replace('~-+~', '-', $text);
    return strtolower($text);
}
}

if (!function_exists('active_languages')) {
function active_languages(): array
{
    try {
        return \App\Core\Database::getInstance()->fetchAll(
            "SELECT code, name, flag FROM languages WHERE is_active = 1 ORDER BY sort_order ASC"
        );
    } catch (\Throwable) {
        return [
            ['code' => 'de', 'name' => 'Deutsch', 'flag' => '🇩🇪'],
            ['code' => 'en', 'name' => 'English', 'flag' => '🇬🇧']
        ];
    }
}
}

if (!function_exists('get_menu')) {
function get_menu(string $location): array
{
    try {
        $db = \App\Core\Database::getInstance();
        $lang = $_SESSION['lang'] ?? 'de';
        $menuId = $db->fetchColumn("SELECT id FROM menus WHERE location = ?", [$location]);
        if (!$menuId) return [];

        return $db->fetchAll("
            SELECT mi.*, COALESCE(mit.title, mi.title) as title
            FROM menu_items mi
            LEFT JOIN menu_item_translations mit ON mi.id = mit.menu_item_id AND mit.lang_code = ?
            WHERE mi.menu_id = ?
            ORDER BY mi.sort_order ASC
        ", [$lang, $menuId]);
    } catch (\Throwable) {
        return [];
    }
}
}

if (!function_exists('session_flash_get')) {
function session_flash_get(): array
{
    $flashes = $_SESSION['_flash'] ?? [];
    unset($_SESSION['_flash']);
    return $flashes;
}
}
