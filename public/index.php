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

// ── Load .env early manually (for config helper usage outside MVC container)
$envFile = ROOT_PATH . '/.env';
if (file_exists($envFile)) {
    $lines = file($envFile, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lines as $line) {
        if (str_starts_with(trim($line), '#')) continue;
        if (str_contains($line, '=')) {
            [$name, $value] = explode('=', $line, 2);
            $name = trim($name);
            $value = trim($value, " \t\n\r\0\x0B\"'");
            if (!array_key_exists($name, $_SERVER) && !array_key_exists($name, $_ENV)) {
                putenv(sprintf('%s=%s', $name, $value));
                $_ENV[$name] = $value;
                $_SERVER[$name] = $value;
            }
        }
    }
}

// ── Bootstrap ────────────────────────────────
$app = require CONFIG_PATH . '/bootstrap.php';

// ── Run ──────────────────────────────────────
$app->run();
