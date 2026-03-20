<?php

namespace App\Services;

class BranchService {
    public static function getCurrent(): array {
        static $branch = null;
        if ($branch) return $branch;
        try {
            $db = \App\Core\Database::getInstance();
            $branchId = $_SESSION['branch_id'] ?? 1;
            $branch = $db->fetchOne("SELECT * FROM branches WHERE id = ?", [$branchId]);
        } catch (\Throwable) {}
        return $branch ?? ['id'=>1,'name'=>'TechStore','slug'=>'main','currency_code'=>'EUR','allows_shipping'=>1,'allows_pickup'=>1];
    }
}

class CartService {
    public static function count(): int {
        try {
            $db = \App\Core\Database::getInstance();
            $sessionId = session_id();
            $cart = $db->fetchOne("SELECT id FROM carts WHERE session_id = ?", [$sessionId]);
            if (!$cart) return 0;
            return (int) $db->fetchColumn("SELECT COALESCE(SUM(quantity),0) FROM cart_items WHERE cart_id = ?", [$cart['id']]);
        } catch (\Throwable) { return 0; }
    }
}

class CacheService {
    private static ?self $instance = null;
    public static function getInstance(): self { return self::$instance ??= new self(); }
    public function get(string $key): mixed {
        $file = STORAGE_PATH . '/cache/' . md5($key);
        if (!file_exists($file)) return null;
        $data = unserialize(file_get_contents($file));
        if ($data['expires'] < time()) { unlink($file); return null; }
        return $data['value'];
    }
    public function set(string $key, mixed $value, int $ttl = 3600): void {
        $file = STORAGE_PATH . '/cache/' . md5($key);
        file_put_contents($file, serialize(['value' => $value, 'expires' => time() + $ttl]));
    }
    public function forget(string $pattern): void {
        foreach (glob(STORAGE_PATH . '/cache/*') as $f) @unlink($f);
    }
}
