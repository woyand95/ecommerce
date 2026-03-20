<?php

// ─────────────────────────────────────────────
//  public/index.php — Front Controller
//  All HTTP requests are routed here via .htaccess
// ─────────────────────────────────────────────

declare(strict_types=1);

// ── Constants ────────────────────────────────
define('APP_VERSION', '1.0.0');
define('ROOT_PATH',    dirname(__DIR__));
define('APP_PATH',     ROOT_PATH . '/app');
define('CONFIG_PATH',  ROOT_PATH . '/config');
define('TEMPLATES_PATH', ROOT_PATH . '/templates');
define('STORAGE_PATH', ROOT_PATH . '/storage');
define('PUBLIC_PATH',  __DIR__);

// ── Autoload ─────────────────────────────────
require ROOT_PATH . '/vendor/autoload.php';

// ── Bootstrap ────────────────────────────────
$app = require CONFIG_PATH . '/bootstrap.php';

// ── Run ──────────────────────────────────────
$app->run();
