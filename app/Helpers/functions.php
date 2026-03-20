<?php

/**
 * Global helper functions — available everywhere in the app.
 */

// ── Translation ───────────────────────────────────────────

function __(string $key, array $replace = []): string
{
    return \App\Core\Lang::getInstance()->get($key, $replace);
}

function __e(string $key, array $replace = []): string
{
    return htmlspecialchars(__($key, $replace), ENT_QUOTES, 'UTF-8');
}

// ── Config ────────────────────────────────────────────────

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

// ── Money formatting ──────────────────────────────────────

function format_money(float|string $amount, string $currency = 'EUR', string $locale = 'de_DE'): string
{
    return (new NumberFormatter($locale, NumberFormatter::CURRENCY))
        ->formatCurrency((float) $amount, $currency);
}

// ── Session flash messages ────────────────────────────────

function session_flash(string $type, string $message): void
{
    $_SESSION['_flash'][$type][] = $message;
}

function session_flash_get(): array
{
    $messages = $_SESSION['_flash'] ?? [];
    unset($_SESSION['_flash']);
    return $messages;
}

// ── Request helpers ───────────────────────────────────────

function request_path(): string
{
    return '/' . ltrim(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH), '/');
}

function request_is(string $path): bool
{
    return str_starts_with(request_path(), $path);
}

// ── Active languages ──────────────────────────────────────

function active_languages(): array
{
    static $langs = null;
    if ($langs === null) {
        $langs = \App\Core\Database::getInstance()->fetchAll(
            "SELECT * FROM languages WHERE is_active=1 ORDER BY sort_order"
        );
    }
    return $langs;
}

// ── Menu helper ───────────────────────────────────────────

function get_menu(string $location, string $lang = 'de'): array
{
    $cacheKey = "menu:$location:$lang";
    $cache    = \App\Services\CacheService::getInstance();
    $cached   = $cache->get($cacheKey);
    if ($cached !== null) return $cached;

    $db   = \App\Core\Database::getInstance();
    $branchId = $_SESSION['branch_id'] ?? 1;

    $items = $db->fetchAll("
        SELECT mi.id, mi.parent_id, mi.type, mi.url, mi.target,
               COALESCE(mit.label, '') as label
        FROM menus m
        JOIN menu_items mi ON mi.menu_id = m.id
        LEFT JOIN menu_item_translations mit ON mit.item_id = mi.id AND mit.lang_code = ?
        WHERE m.location = ? AND (m.branch_id = ? OR m.branch_id IS NULL)
        ORDER BY mi.sort_order
    ", [$lang, $location, $branchId]);

    // Build tree
    $tree  = [];
    $byId  = [];
    foreach ($items as &$item) { $item['children'] = []; $byId[$item['id']] = &$item; }
    foreach ($items as &$item) {
        if ($item['parent_id'] && isset($byId[$item['parent_id']])) {
            $byId[$item['parent_id']]['children'][] = &$item;
        } else {
            $tree[] = &$item;
        }
    }

    $cache->set($cacheKey, $tree, 3600);
    return $tree;
}

// ── Asset helper ──────────────────────────────────────────

function asset(string $path): string
{
    $full = PUBLIC_PATH . '/assets/' . ltrim($path, '/');
    $ver  = file_exists($full) ? '?v=' . substr(md5_file($full), 0, 8) : '';
    return '/assets/' . ltrim($path, '/') . $ver;
}

// ── URL helper ────────────────────────────────────────────

function url(string $path = '', string $lang = ''): string
{
    $lang = $lang ?: ($_SESSION['lang'] ?? 'de');
    return '/' . $lang . '/' . ltrim($path, '/');
}

// ── Admin nav item helper ─────────────────────────────────

function admin_nav_item(string $href, string $icon, string $label): string
{
    $active = str_starts_with(request_path(), $href) ? ' active' : '';
    return sprintf(
        '<a href="%s" class="admin-nav-link%s">%s<span>%s</span></a>',
        htmlspecialchars($href),
        $active,
        admin_icon($icon),
        htmlspecialchars($label)
    );
}

function admin_icon(string $name): string
{
    // Returns inline SVG snippet — in production, use an SVG sprite
    $icons = [
        'dashboard'    => '<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>',
        'box'          => '<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"/></svg>',
        'shopping-bag' => '<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/><line x1="3" y1="6" x2="23" y2="6"/></svg>',
        'users'        => '<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>',
        'layout'       => '<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="18" height="18" rx="2"/><path d="M3 9h18M9 21V9"/></svg>',
        'git-branch'   => '<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><line x1="6" y1="3" x2="6" y2="15"/><circle cx="18" cy="6" r="3"/><circle cx="6" cy="18" r="3"/><path d="M18 9a9 9 0 0 1-9 9"/></svg>',
        'settings'     => '<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83-2.83l.06-.06A1.65 1.65 0 0 0 4.68 15a1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 2.83-2.83l.06.06A1.65 1.65 0 0 0 9 4.68a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 2.83l-.06.06A1.65 1.65 0 0 0 19.4 9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z"/></svg>',
        'tag'          => '<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M20.59 13.41l-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z"/><line x1="7" y1="7" x2="7.01" y2="7"/></svg>',
        'folder'       => '<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"/></svg>',
        'image'        => '<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="18" height="18" rx="2"/><circle cx="8.5" cy="8.5" r="1.5"/><polyline points="21 15 16 10 5 21"/></svg>',
        'globe'        => '<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="2" y1="12" x2="22" y2="12"/><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"/></svg>',
        'shield'       => '<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>',
        'file-text'    => '<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/><polyline points="10 9 9 9 8 9"/></svg>',
        'menu'         => '<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="18" x2="21" y2="18"/></svg>',
        'bell'         => '<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/></svg>',
        'sliders'      => '<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><line x1="4" y1="21" x2="4" y2="14"/><line x1="4" y1="10" x2="4" y2="3"/><line x1="12" y1="21" x2="12" y2="12"/><line x1="12" y1="8" x2="12" y2="3"/><line x1="20" y1="21" x2="20" y2="16"/><line x1="20" y1="12" x2="20" y2="3"/><line x1="1" y1="14" x2="7" y2="14"/><line x1="9" y1="8" x2="15" y2="8"/><line x1="17" y1="16" x2="23" y2="16"/></svg>',
        'panel-left'   => '<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="18" height="18" rx="2"/><line x1="9" y1="3" x2="9" y2="21"/></svg>',
    ];
    return $icons[$name] ?? '<svg width="16" height="16"></svg>';
}

// ── Date helpers ──────────────────────────────────────────

function time_ago(string $date): string
{
    $diff = time() - strtotime($date);
    if ($diff < 60)       return "just now";
    if ($diff < 3600)     return floor($diff / 60) . "m ago";
    if ($diff < 86400)    return floor($diff / 3600) . "h ago";
    if ($diff < 604800)   return floor($diff / 86400) . "d ago";
    return date('d.m.Y', strtotime($date));
}

function format_date(string $date, string $format = 'd.m.Y H:i'): string
{
    return date($format, strtotime($date));
}

// ── Truncate ──────────────────────────────────────────────

function truncate(string $text, int $length = 100, string $suffix = '…'): string
{
    return mb_strlen($text) > $length
        ? mb_substr($text, 0, $length) . $suffix
        : $text;
}

// ── Ordinal number ────────────────────────────────────────

function ordinal(int $n): string
{
    $suffix = ['th','st','nd','rd'];
    $v = $n % 100;
    return $n . ($suffix[($v - 20) % 10] ?? $suffix[$v] ?? $suffix[0]);
}
