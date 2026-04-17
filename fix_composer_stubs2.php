<?php
$content = file_get_contents('composer.json');
$search = '"exclude-from-classmap": ["app/Core/Stubs.php", "app/Models/Stubs.php", "app/Middleware/Stubs.php", "app/Controllers/Stubs.php"],';
$replace = '';
$content = str_replace($search, $replace, $content);

$search2 = '"classmap": ["app/Services/CoreServices.php"],';
$replace2 = '"classmap": ["app/Core/Stubs.php", "app/Models/Stubs.php", "app/Middleware/Stubs.php", "app/Controllers/Stubs.php", "app/Services/CoreServices.php"],';
$content = str_replace($search2, $replace2, $content);

file_put_contents('composer.json', $content);
