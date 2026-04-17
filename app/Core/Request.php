<?php

namespace App\Core;

/**
 * Request class - HTTP request wrapper
 */
class Request
{
    private string $lang = 'de';
    private array $routeParams = [];

    public function method(): string
    {
        return strtoupper($_SERVER['REQUEST_METHOD'] ?? 'GET');
    }

    public function query(string $key, mixed $default = null): mixed
    {
        return $_GET[$key] ?? $default;
    }

    public function input(string $key, mixed $default = null): mixed
    {
        return $_POST[$key] ?? $default;
    }

    public function all(): array
    {
        return array_merge($_GET, $_POST);
    }

    public function json(): array
    {
        $content = file_get_contents('php://input');
        return json_decode($content, true) ?? [];
    }

    public function param(string $key): mixed
    {
        return $this->routeParams[$key] ?? null;
    }

    public function setParams(array $params): void
    {
        $this->routeParams = $params;
    }

    public function header(string $key, mixed $default = null): mixed
    {
        $key = 'HTTP_' . strtoupper(str_replace('-', '_', $key));
        return $_SERVER[$key] ?? $default;
    }

    public function hasFile(string $key): bool
    {
        return isset($_FILES[$key]) && $_FILES[$key]['error'] === UPLOAD_ERR_OK;
    }

    public function file(string $key): array
    {
        return $_FILES[$key] ?? [];
    }

    public function files(string $key): array
    {
        return $this->file($key);
    }

    public function isApi(): bool
    {
        return str_starts_with($_SERVER['REQUEST_URI'] ?? '', '/api');
    }

    public function setLang(string $lang): void
    {
        $this->lang = $lang;
        $_SESSION['lang'] = $lang;
    }

    public function getLang(): string
    {
        return $_SESSION['lang'] ?? $this->lang;
    }

    public function uri(): string
    {
        return parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH);
    }

    public function baseUrl(): string
    {
        $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
        $host = $_SERVER['HTTP_HOST'] ?? 'localhost';
        return $protocol . '://' . $host;
    }

    public function fullUrl(): string
    {
        return $this->baseUrl() . $_SERVER['REQUEST_URI'] ?? '';
    }

    public function ajax(): bool
    {
        return !empty($_SERVER['HTTP_X_REQUESTED_WITH']) 
            && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest';
    }
}
