<?php

namespace App\Models;

use App\Core\Database;
use App\Core\Model;

/**
 * Product Model — handles product retrieval with branch-specific pricing,
 * stock, and multilingual translations.
 */
class Product extends Model
{
    protected static string $table       = 'products';
    protected static bool   $timestamps  = true;
    protected static bool   $branchScoped = false; // Products are global; prices are branch-specific

    // ── Branch-aware product listing ─────────────────────────

    /**
     * Get all active products for a branch with translated fields and branch price.
     *
     * @param int    $branchId   Branch to scope prices/stock to
     * @param string $lang       Language code for translations
     * @param string $priceGroup Customer price group ('standard', 'b2b', 'vip')
     */
    public function getForBranch(
        int    $branchId,
        string $lang       = 'de',
        string $priceGroup = 'standard',
        int    $limit      = 24,
        int    $offset     = 0
    ): array {
        $sql = "
            SELECT
                p.id,
                p.sku,
                p.type,
                p.is_featured,
                COALESCE(pt.name,        pt_fb.name)             AS name,
                COALESCE(pt.url_slug,    pt_fb.url_slug)         AS url_slug,
                COALESCE(pt.meta_title,  pt_fb.meta_title)       AS meta_title,
                COALESCE(pt.short_description, pt_fb.short_description) AS short_description,
                -- Price: sale_price if active, otherwise regular price
                CASE
                    WHEN pbp.sale_price IS NOT NULL
                         AND NOW() BETWEEN COALESCE(pbp.sale_from, '1970-01-01')
                                       AND COALESCE(pbp.sale_until, '2099-12-31')
                    THEN pbp.sale_price
                    ELSE pbp.price
                END                                              AS price,
                pbp.price                                        AS original_price,
                pbp.sale_price,
                pbs.quantity                                     AS stock_qty,
                pbs.allow_backorder,
                pi.file_path                                     AS primary_image
            FROM products p
            -- Translated content with fallback to default lang
            LEFT JOIN product_translations pt
                   ON pt.product_id = p.id AND pt.lang_code = :lang
            LEFT JOIN product_translations pt_fb
                   ON pt_fb.product_id = p.id AND pt_fb.lang_code = 'de'
            -- Branch-specific pricing
            LEFT JOIN product_branch_prices pbp
                   ON pbp.product_id = p.id
                  AND pbp.branch_id  = :branch_id
                  AND pbp.price_group = :price_group
                  AND pbp.variant_id IS NULL
            -- Branch-specific stock
            LEFT JOIN product_branch_stock pbs
                   ON pbs.product_id = p.id
                  AND pbs.branch_id  = :branch_id2
                  AND pbs.variant_id IS NULL
            -- Primary image
            LEFT JOIN product_images pi
                   ON pi.product_id = p.id AND pi.is_primary = 1
            WHERE p.is_active = 1
              AND pbp.price IS NOT NULL  -- Only products with a price for this branch
            ORDER BY p.sort_order ASC, p.created_at DESC
            LIMIT :limit OFFSET :offset
        ";

        return $this->db->fetchAll($sql, [
            'lang'        => $lang,
            'branch_id'   => $branchId,
            'price_group' => $priceGroup,
            'branch_id2'  => $branchId,
            'limit'       => $limit,
            'offset'      => $offset,
        ]);
    }

    /**
     * Get full product detail including all images, variants, and category.
     */
    public function getDetail(int $productId, int $branchId, string $lang = 'de', string $priceGroup = 'standard'): ?array
    {
        $sql = "
            SELECT
                p.*,
                COALESCE(pt.name, pt_fb.name)                   AS name,
                COALESCE(pt.description, pt_fb.description)     AS description,
                COALESCE(pt.short_description, pt_fb.short_description) AS short_description,
                COALESCE(pt.url_slug, pt_fb.url_slug)           AS url_slug,
                COALESCE(pt.meta_title, pt_fb.meta_title)       AS meta_title,
                COALESCE(pt.meta_description, pt_fb.meta_description) AS meta_description,
                COALESCE(ct.name, ct_fb.name)                   AS category_name,
                CASE
                    WHEN pbp.sale_price IS NOT NULL
                         AND NOW() BETWEEN COALESCE(pbp.sale_from,'1970-01-01')
                                       AND COALESCE(pbp.sale_until,'2099-12-31')
                    THEN pbp.sale_price
                    ELSE pbp.price
                END                                             AS price,
                pbp.price                                       AS original_price,
                pbs.quantity                                    AS stock_qty,
                pbs.allow_backorder
            FROM products p
            LEFT JOIN product_translations pt
                   ON pt.product_id = p.id AND pt.lang_code = ?
            LEFT JOIN product_translations pt_fb
                   ON pt_fb.product_id = p.id AND pt_fb.lang_code = 'de'
            LEFT JOIN categories c ON c.id = p.category_id
            LEFT JOIN category_translations ct
                   ON ct.category_id = c.id AND ct.lang_code = ?
            LEFT JOIN category_translations ct_fb
                   ON ct_fb.category_id = c.id AND ct_fb.lang_code = 'de'
            LEFT JOIN product_branch_prices pbp
                   ON pbp.product_id = p.id AND pbp.branch_id = ? AND pbp.price_group = ? AND pbp.variant_id IS NULL
            LEFT JOIN product_branch_stock pbs
                   ON pbs.product_id = p.id AND pbs.branch_id = ? AND pbs.variant_id IS NULL
            WHERE p.id = ? AND p.is_active = 1
        ";

        $product = $this->db->fetchOne($sql, [$lang, $lang, $branchId, $priceGroup, $branchId, $productId]);

        if (!$product) return null;

        // Load images
        $product['images'] = $this->db->fetchAll(
            "SELECT * FROM product_images WHERE product_id = ? ORDER BY sort_order, is_primary DESC",
            [$productId]
        );

        // Load variants with branch prices
        $product['variants'] = $this->getVariantsForBranch($productId, $branchId, $priceGroup);

        return $product;
    }

    /**
     * Find product by translated slug + branch check.
     */
    public function findBySlug(string $slug, int $branchId, string $lang = 'de'): ?array
    {
        $row = $this->db->fetchOne(
            "SELECT p.id FROM products p
             JOIN product_translations pt ON pt.product_id = p.id
             WHERE pt.url_slug = ? AND pt.lang_code = ? AND p.is_active = 1 LIMIT 1",
            [$slug, $lang]
        );

        if (!$row) return null;
        return $this->getDetail($row['id'], $branchId, $lang);
    }

    // ── Variants ─────────────────────────────────────────────

    public function getVariantsForBranch(int $productId, int $branchId, string $priceGroup): array
    {
        return $this->db->fetchAll("
            SELECT
                pv.*,
                CASE
                    WHEN pbp.sale_price IS NOT NULL
                         AND NOW() BETWEEN COALESCE(pbp.sale_from,'1970-01-01')
                                       AND COALESCE(pbp.sale_until,'2099-12-31')
                    THEN pbp.sale_price
                    ELSE pbp.price
                END                     AS price,
                pbp.price               AS original_price,
                pbs.quantity            AS stock_qty,
                pbs.allow_backorder
            FROM product_variants pv
            LEFT JOIN product_branch_prices pbp
                   ON pbp.variant_id = pv.id AND pbp.branch_id = ? AND pbp.price_group = ?
            LEFT JOIN product_branch_stock pbs
                   ON pbs.variant_id = pv.id AND pbs.branch_id = ?
            WHERE pv.product_id = ? AND pv.is_active = 1
            ORDER BY pv.id
        ", [$branchId, $priceGroup, $branchId, $productId]);
    }

    // ── Stock ─────────────────────────────────────────────────

    public function isAvailable(int $productId, int $branchId, int $qty = 1, ?int $variantId = null): bool
    {
        $sql = "SELECT quantity, allow_backorder FROM product_branch_stock
                WHERE product_id = ? AND branch_id = ?";
        $params = [$productId, $branchId];

        if ($variantId) {
            $sql      .= ' AND variant_id = ?';
            $params[]  = $variantId;
        } else {
            $sql .= ' AND variant_id IS NULL';
        }

        $stock = $this->db->fetchOne($sql, $params);
        if (!$stock) return false;

        return $stock['allow_backorder'] || ($stock['quantity'] >= $qty);
    }

    /**
     * Atomically reserve stock (decrements available, increments reserved).
     * Called during order placement — wrapped in a transaction.
     */
    public function reserveStock(int $productId, int $branchId, int $qty, ?int $variantId = null): bool
    {
        $sql = "UPDATE product_branch_stock
                SET quantity     = quantity - :qty,
                    reserved_qty = reserved_qty + :qty2
                WHERE product_id = :pid
                  AND branch_id  = :bid
                  AND (quantity >= :qty3 OR allow_backorder = 1)";

        $params = $variantId
            ? array_merge(compact('qty', 'variantId'), ['pid' => $productId, 'bid' => $branchId, 'qty2' => $qty, 'qty3' => $qty])
            : ['qty' => $qty, 'qty2' => $qty, 'qty3' => $qty, 'pid' => $productId, 'bid' => $branchId];

        if ($variantId) $sql .= ' AND variant_id = :variantId';
        else            $sql .= ' AND variant_id IS NULL';

        $affected = $this->db->execute($sql, $params)->rowCount();
        return $affected > 0;
    }

    // ── Search ────────────────────────────────────────────────

    public function search(string $query, int $branchId, string $lang = 'de', int $limit = 20): array
    {
        $term = '%' . $query . '%';
        return $this->db->fetchAll("
            SELECT p.id, p.sku,
                   COALESCE(pt.name, pt_fb.name)             AS name,
                   COALESCE(pt.url_slug, pt_fb.url_slug)     AS url_slug,
                   pbp.price,
                   pi.file_path AS primary_image
            FROM products p
            LEFT JOIN product_translations pt ON pt.product_id=p.id AND pt.lang_code=?
            LEFT JOIN product_translations pt_fb ON pt_fb.product_id=p.id AND pt_fb.lang_code='de'
            LEFT JOIN product_branch_prices pbp ON pbp.product_id=p.id AND pbp.branch_id=? AND pbp.variant_id IS NULL
            LEFT JOIN product_images pi ON pi.product_id=p.id AND pi.is_primary=1
            WHERE p.is_active=1 AND pbp.price IS NOT NULL
              AND (pt.name LIKE ? OR p.sku LIKE ? OR pt_fb.name LIKE ?)
            LIMIT ?
        ", [$lang, $branchId, $term, $term, $term, $limit]);
    }
}
