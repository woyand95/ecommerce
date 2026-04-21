<?php
// ── Stub-Klassen damit der Dev-Server startet ─────────────
// Diese Dateien ersetzen später die vollständigen Implementierungen.

namespace App\Core;

class Request {
    private string $lang = 'de';
    public function method(): string { return strtoupper($_SERVER['REQUEST_METHOD'] ?? 'GET'); }
    public function query(string $key, mixed $default = null): mixed { return $_GET[$key] ?? $default; }
    public function input(string $key, mixed $default = null): mixed { return $_POST[$key] ?? $default; }
    public function all(): array { return array_merge($_GET, $_POST); }
    public function param(string $key): mixed { return null; }
    public function header(string $key, mixed $default = null): mixed { return $_SERVER['HTTP_' . strtoupper(str_replace('-','_',$key))] ?? $default; }
    public function hasFile(string $key): bool { return isset($_FILES[$key]); }
    public function files(string $key): array { return $_FILES[$key] ?? []; }
    public function isApi(): bool { return str_starts_with($_SERVER['REQUEST_URI'] ?? '', '/api'); }
    public function setLang(string $lang): void { $this->lang = $lang; $_SESSION['lang'] = $lang; }
    public function getLang(): string { return $this->lang; }
}

class Response {
    public function json(mixed $data, int $status = 200): void {
        http_response_code($status);
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode($data, JSON_UNESCAPED_UNICODE);
        exit;
    }
    public function redirect(string $url, int $status = 302): void {
        http_response_code($status);
        header("Location: $url");
        exit;
    }
    public function setStatusCode(int $code): void { http_response_code($code); }
    public function internalError(\Throwable $e): void {
        http_response_code(500);
        echo defined('APP_DEBUG') && APP_DEBUG
            ? '<pre>' . $e->getMessage() . "\n" . $e->getTraceAsString() . '</pre>'
            : '<h1>500 – Internal Server Error</h1>';
    }
}

class Auth {
    private static ?self $instance = null;
    public static function getInstance(): self { return self::$instance ??= new self(); }
    public function check(): bool { return isset($_SESSION['customer_id']); }
    public function getCustomer(): ?array { return $_SESSION['customer'] ?? null; }
    public static function customer(): ?array { return $_SESSION['customer'] ?? null; }
    public function adminUser(): ?array { return $_SESSION['admin_user'] ?? null; }
    public function adminCheck(): bool { return isset($_SESSION['admin_id']); }

}

class Lang {
    private static ?self $instance = null;
    private array $translations = [];
    private string $current = 'de';

    public static function getInstance(): self { return self::$instance ??= new self(); }

    public function getCurrent(): string { return $_SESSION['lang'] ?? $this->current; }

    public function get(string $key, array $replace = []): string {
        if (empty($this->translations)) $this->load($this->getCurrent());
        $value = $this->translations[$key] ?? $key;
        foreach ($replace as $k => $v) $value = str_replace(":$k", $v, $value);
        return $value;
    }

    private function load(string $lang): void {
        $file = ROOT_PATH . "/lang/$lang/general.php";
        $this->translations = file_exists($file) ? require $file : [];
    }
}

class Csrf {
    public static function token(): string {
        if (empty($_SESSION['csrf_token'])) {
            $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
        }
        return $_SESSION['csrf_token'];
    }
    public static function validate(string $token): bool {
        return hash_equals($_SESSION['csrf_token'] ?? '', $token);
    }
}
