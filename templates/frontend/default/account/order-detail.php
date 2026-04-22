<?php clone $v; $v->extend('main'); ?>
<?php $v->section('account_content'); ?>

<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 32px;">
    <h1 style="font-size: 1.75rem; font-weight: 800; color: var(--color-gray-900);">Bestelldetails</h1>
    <a href="<?= $v->url('/account/orders') ?>" style="color: var(--color-primary); font-weight: 600; text-decoration: none;">&larr; Zurück</a>
</div>

<div style="background: var(--color-gray-50); border-radius: var(--radius-lg); border: 1px solid var(--color-gray-200); padding: 24px; margin-bottom: 32px;">
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 24px;">
        <div>
            <div style="font-size: 13px; color: var(--color-gray-500); text-transform: uppercase; font-weight: 600; letter-spacing: 0.05em; margin-bottom: 8px;">Bestellnummer</div>
            <div style="font-size: 1.1rem; font-weight: 700; color: var(--color-gray-900);"><?= $v->e($order['order_number']) ?></div>
        </div>
        <div>
            <div style="font-size: 13px; color: var(--color-gray-500); text-transform: uppercase; font-weight: 600; letter-spacing: 0.05em; margin-bottom: 8px;">Datum</div>
            <div style="font-size: 1rem; color: var(--color-gray-700);"><?= date('d.m.Y H:i', strtotime($order['created_at'])) ?></div>
        </div>
        <div>
            <div style="font-size: 13px; color: var(--color-gray-500); text-transform: uppercase; font-weight: 600; letter-spacing: 0.05em; margin-bottom: 8px;">Status</div>
            <div style="display: inline-block; padding: 4px 12px; border-radius: 9999px; font-size: 12px; font-weight: 700; text-transform: uppercase; background: <?= $order['status'] === 'delivered' ? 'var(--color-success-light)' : 'var(--color-warning-light)' ?>; color: <?= $order['status'] === 'delivered' ? 'var(--color-success)' : 'var(--color-warning)' ?>;">
                <?= $v->e(ucfirst($order['status'])) ?>
            </div>
        </div>
        <div>
            <div style="font-size: 13px; color: var(--color-gray-500); text-transform: uppercase; font-weight: 600; letter-spacing: 0.05em; margin-bottom: 8px;">Gesamtbetrag</div>
            <div style="font-size: 1.25rem; font-weight: 800; color: var(--color-gray-900);"><?= format_money($order['total']) ?></div>
        </div>
    </div>
</div>

<h2 style="font-size: 1.25rem; font-weight: 700; margin-bottom: 16px; color: var(--color-gray-800);">Artikel</h2>
<div style="border: 1px solid var(--color-gray-200); border-radius: var(--radius-lg); overflow: hidden; margin-bottom: 32px;">
    <table style="width: 100%; border-collapse: collapse; text-align: left;">
        <thead style="background: var(--color-gray-50); border-bottom: 1px solid var(--color-gray-200);">
            <tr>
                <th style="padding: 16px 24px; font-size: 13px; color: var(--color-gray-500); font-weight: 600; text-transform: uppercase; letter-spacing: 0.05em;">Produkt</th>
                <th style="padding: 16px 24px; font-size: 13px; color: var(--color-gray-500); font-weight: 600; text-transform: uppercase; letter-spacing: 0.05em; text-align: center;">Menge</th>
                <th style="padding: 16px 24px; font-size: 13px; color: var(--color-gray-500); font-weight: 600; text-transform: uppercase; letter-spacing: 0.05em; text-align: right;">Preis</th>
                <th style="padding: 16px 24px; font-size: 13px; color: var(--color-gray-500); font-weight: 600; text-transform: uppercase; letter-spacing: 0.05em; text-align: right;">Gesamt</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach($items as $item): ?>
            <tr style="border-bottom: 1px solid var(--color-gray-100); transition: background 0.2s;" onmouseover="this.style.background='var(--color-gray-50)'" onmouseout="this.style.background='transparent'">
                <td style="padding: 16px 24px;">
                    <div style="display: flex; align-items: center; gap: 16px;">
                        <img src="<?= $v->asset('img/' . ($item['image_url'] ?? 'placeholder.webp')) ?>" alt="" style="width: 48px; height: 48px; object-fit: contain; border-radius: 8px; border: 1px solid var(--color-gray-200); background: white;">
                        <div>
                            <div style="font-weight: 600; color: var(--color-gray-900); margin-bottom: 4px;">
                                <a href="<?= $v->url('/products/' . $item['url_slug']) ?>" style="color: inherit; text-decoration: none;" onmouseover="this.style.color='var(--color-primary)'" onmouseout="this.style.color='inherit'"><?= $v->e($item['product_name']) ?></a>
                            </div>
                            <div style="font-size: 13px; color: var(--color-gray-500);">SKU: <?= $v->e($item['sku']) ?></div>
                        </div>
                    </div>
                </td>
                <td style="padding: 16px 24px; text-align: center; font-weight: 500; color: var(--color-gray-700);"><?= $item['quantity'] ?></td>
                <td style="padding: 16px 24px; text-align: right; color: var(--color-gray-700);"><?= format_money($item['unit_price']) ?></td>
                <td style="padding: 16px 24px; text-align: right; font-weight: 600; color: var(--color-gray-900);"><?= format_money($item['line_total']) ?></td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 32px;">
    <?php if ($address): ?>
    <div>
        <h2 style="font-size: 1.25rem; font-weight: 700; margin-bottom: 16px; color: var(--color-gray-800);">Lieferadresse</h2>
        <div style="background: white; border: 1px solid var(--color-gray-200); border-radius: var(--radius-lg); padding: 24px;">
            <div style="font-weight: 600; margin-bottom: 8px; color: var(--color-gray-900);"><?= $v->e($address['first_name'] . ' ' . $address['last_name']) ?></div>
            <?php if (!empty($address['company'])): ?>
                <div style="color: var(--color-gray-700); margin-bottom: 4px;"><?= $v->e($address['company']) ?></div>
            <?php endif; ?>
            <div style="color: var(--color-gray-600); line-height: 1.6;">
                <?= $v->e($address['street'] ?? $address['address_line1'] ?? '') ?><br>
                <?= $v->e($address['postal_code'] . ' ' . $address['city']) ?><br>
                <?= $v->e($address['country_code']) ?>
            </div>
        </div>
    </div>
    <?php endif; ?>

    <div>
        <h2 style="font-size: 1.25rem; font-weight: 700; margin-bottom: 16px; color: var(--color-gray-800);">Abrechnung</h2>
        <div style="background: white; border: 1px solid var(--color-gray-200); border-radius: var(--radius-lg); padding: 24px;">
            <div style="display: flex; flex-direction: column; gap: 12px; font-size: 14px;">
                <div style="display: flex; justify-content: space-between;">
                    <span style="color: var(--color-gray-600);">Zwischensumme</span>
                    <span style="font-weight: 500; color: var(--color-gray-900);"><?= format_money($order['subtotal']) ?></span>
                </div>
                <div style="display: flex; justify-content: space-between;">
                    <span style="color: var(--color-gray-600);">Versand</span>
                    <span style="font-weight: 500; color: var(--color-gray-900);"><?= format_money($order['shipping_cost']) ?></span>
                </div>
                <?php if ($order['discount_amount'] > 0): ?>
                <div style="display: flex; justify-content: space-between;">
                    <span style="color: var(--color-gray-600);">Rabatt</span>
                    <span style="font-weight: 500; color: var(--color-danger);">- <?= format_money($order['discount_amount']) ?></span>
                </div>
                <?php endif; ?>
                <div style="display: flex; justify-content: space-between; font-size: 1.1rem; font-weight: 800; color: var(--color-gray-900); border-top: 1px solid var(--color-gray-200); margin-top: 8px; padding-top: 16px;">
                    <span>Gesamtsumme</span>
                    <span><?= format_money($order['total']) ?></span>
                </div>
                <div style="display: flex; justify-content: space-between; font-size: 13px; margin-top: 8px;">
                    <span style="color: var(--color-gray-500);">Zahlungsmethode</span>
                    <span style="font-weight: 600; color: var(--color-primary); text-transform: uppercase;"><?= $v->e($order['payment_method']) ?></span>
                </div>
            </div>
        </div>
    </div>
</div>

<?php $v->endSection(); ?>
<?php require __DIR__ . '/layout.php'; ?>
