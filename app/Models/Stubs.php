<?php

namespace App\Models;
use App\Core\{Model, Database};

class Branch extends Model {
    protected static string $table = 'branches';
    public static function findByDomain(string $domain): ?array {
        return Database::getInstance()->fetchOne(
            "SELECT * FROM branches WHERE domain = ? OR subdomain = ? LIMIT 1",
            [$domain, explode('.', $domain)[0]]
        );
    }
}

class Category extends Model {
    protected static string $table = 'categories';
    public function getTree(string $lang = 'de'): array {
        return $this->db->fetchAll("
            SELECT c.*, COALESCE(ct.name, ct2.name) AS name, COALESCE(ct.url_slug, ct2.url_slug) AS url_slug
            FROM categories c
            LEFT JOIN category_translations ct ON ct.category_id=c.id AND ct.lang_code=?
            LEFT JOIN category_translations ct2 ON ct2.category_id=c.id AND ct2.lang_code='de'
            WHERE c.is_active=1 AND c.parent_id IS NULL
            ORDER BY c.sort_order
        ", [$lang]);
    }
    public function findBySlug(string $slug, string $lang = 'de'): ?array {
        return $this->db->fetchOne("
            SELECT c.*, ct.name, ct.url_slug
            FROM categories c
            JOIN category_translations ct ON ct.category_id=c.id
            WHERE ct.url_slug=? AND ct.lang_code=? AND c.is_active=1 LIMIT 1
        ", [$slug, $lang]);
    }
}

class Customer extends Model {
    protected static string $table = 'customers';
}

class Campaign extends Model {
    protected static string $table = 'campaigns';
    public function applyCoupon(string $code, int $branchId, int $customerId, string $customerType, float $subtotal): array {
        return [0.0, null]; // Stub
    }
    public function incrementUsage(int $campaignId, int $customerId): void {}
}
