<?php
// config/app.php
return [
    'name'     => 'EcommerceSystem',
    'env'      => $_ENV['APP_ENV']   ?? 'production',
    'debug'    => ($_ENV['APP_DEBUG'] ?? 'false') === 'true',
    'url'      => $_ENV['APP_URL']   ?? 'http://localhost',
    'timezone' => 'Europe/Berlin',
    'locale'   => 'de',
];
