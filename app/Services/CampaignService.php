<?php

namespace App\Services;

use App\Core\Database;

class CampaignService {
    
    /**
     * Apply a coupon/campaign code to an order
     * 
     * @param string $code The coupon code
     * @param int $branchId Branch ID
     * @param int $customerId Customer ID
     * @param string $customerType B2B or B2C
     * @param float $subtotal Order subtotal
     * @return array [discount_amount, campaign_data]
     */
    public function applyCoupon(string $code, int $branchId, int $customerId, string $customerType, float $subtotal): array {
        try {
            $db = Database::getInstance();
            
            // Find active campaign with this code
            $campaign = $db->fetchOne("
                SELECT c.*, ct.title, ct.description
                FROM campaigns c
                LEFT JOIN campaign_translations ct ON ct.campaign_id = c.id AND ct.lang_code = 'de'
                WHERE c.code = ? 
                AND c.is_active = 1
                AND c.campaign_type = 'coupon'
                AND (c.starts_at IS NULL OR c.starts_at <= NOW())
                AND (c.ends_at IS NULL OR c.ends_at >= NOW())
            ", [$code]);
            
            if (!$campaign) {
                return [0.0, null];
            }
            
            // Check usage limits
            if ($campaign['max_uses'] !== null) {
                $currentUses = $db->fetchColumn(
                    "SELECT COUNT(*) FROM campaign_uses WHERE campaign_id = ?",
                    [$campaign['id']]
                );
                
                if ($currentUses >= $campaign['max_uses']) {
                    return [0.0, null];
                }
            }
            
            // Check per-customer usage limit
            if ($campaign['max_uses_per_customer'] !== null) {
                $customerUses = $db->fetchColumn(
                    "SELECT COUNT(*) FROM campaign_uses WHERE campaign_id = ? AND customer_id = ?",
                    [$campaign['id'], $customerId]
                );
                
                if ($customerUses >= $campaign['max_uses_per_customer']) {
                    return [0.0, null];
                }
            }
            
            // Check minimum order value
            if ($campaign['min_order_value'] !== null && $subtotal < $campaign['min_order_value']) {
                return [0.0, null];
            }
            
            // Check customer type restriction
            if ($campaign['customer_type'] !== null && $campaign['customer_type'] !== 'ALL' && 
                $campaign['customer_type'] !== $customerType) {
                return [0.0, null];
            }
            
            // Calculate discount
            $discount = 0.0;
            
            switch ($campaign['discount_type']) {
                case 'percentage':
                    $discount = $subtotal * ($campaign['discount_value'] / 100);
                    
                    // Apply max discount cap if set
                    if ($campaign['max_discount_amount'] !== null && $discount > $campaign['max_discount_amount']) {
                        $discount = $campaign['max_discount_amount'];
                    }
                    break;
                    
                case 'fixed':
                    $discount = $campaign['discount_value'];
                    break;
                    
                case 'shipping':
                    // Free shipping - will be handled in checkout
                    $discount = 0.0;
                    break;
            }
            
            // Ensure discount doesn't exceed subtotal
            if ($discount > $subtotal) {
                $discount = $subtotal;
            }
            
            return [(float) $discount, $campaign];
            
        } catch (\Throwable $e) {
            error_log("CampaignService applyCoupon error: " . $e->getMessage());
            return [0.0, null];
        }
    }
    
    /**
     * Record campaign usage
     */
    public function incrementUsage(int $campaignId, int $customerId): void {
        try {
            $db = Database::getInstance();
            
            $db->execute("
                INSERT INTO campaign_uses (campaign_id, customer_id, used_at)
                VALUES (?, ?, NOW())
            ", [$campaignId, $customerId]);
            
        } catch (\Throwable $e) {
            error_log("CampaignService incrementUsage error: " . $e->getMessage());
        }
    }
    
    /**
     * Get active campaigns for a branch
     */
    public function getActiveCampaigns(int $branchId, string $customerType = 'B2C'): array {
        try {
            $db = Database::getInstance();
            
            return $db->fetchAll("
                SELECT c.*, ct.title, ct.description
                FROM campaigns c
                LEFT JOIN campaign_translations ct ON ct.campaign_id = c.id AND ct.lang_code = 'de'
                WHERE c.is_active = 1
                AND c.campaign_type = 'promotion'
                AND (c.branch_id = ? OR c.branch_id IS NULL)
                AND (c.starts_at IS NULL OR c.starts_at <= NOW())
                AND (c.ends_at IS NULL OR c.ends_at >= NOW())
                AND (c.customer_type = 'ALL' OR c.customer_type = ?)
                ORDER BY c.priority DESC, c.created_at DESC
            ", [$branchId, $customerType]);
            
        } catch (\Throwable $e) {
            error_log("CampaignService getActiveCampaigns error: " . $e->getMessage());
            return [];
        }
    }
}
