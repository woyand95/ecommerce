<?php
$content = file_get_contents('composer.json');
$search = '"exclude-from-classmap": ["app/Core/Stubs.php", "app/Models/Stubs.php", "app/Middleware/Stubs.php", "app/Controllers/Stubs.php", "app/Services/CoreServices.php"],';
$replace = '"classmap": ["app/Core/Stubs.php", "app/Models/Stubs.php", "app/Middleware/Stubs.php", "app/Controllers/Stubs.php", "app/Services/CoreServices.php"],';
$content = str_replace($search, $replace, $content);
file_put_contents('composer.json', $content);
