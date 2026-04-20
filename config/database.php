<?php
// config/database.php
return [
    'host'       => $_ENV['DB_HOST']     ?? '127.0.0.1',
    'port'       => $_ENV['DB_PORT']     ?? '3306',
    'database'   => $_ENV['DB_DATABASE'] ?? 'ecommerce',
    'username'   => $_ENV['DB_USERNAME'] ?? 'techstore',
    'password'   => $_ENV['DB_PASSWORD'] ?? 'techstore123',
    'persistent' => false,
];
