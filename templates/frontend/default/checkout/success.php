<?php $v->extend('main'); ?>

<section class="section-success" style="padding: 64px 20px; background: var(--color-gray-50); min-height: 70vh;">
    <div class="container" style="max-width: 600px;">
        <div style="background: white; border: 1px solid var(--color-gray-200); border-radius: var(--radius-xl); padding: 48px 32px; text-align: center; box-shadow: var(--shadow-sm);">

            <div style="width: 80px; height: 80px; background: var(--color-success-light, #d1fae5); color: var(--color-success, #10b981); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 24px;">
                <svg width="40" height="40" fill="none" stroke="currentColor" stroke-width="3">
                    <path d="M20 6L9 17l5 5"></path>
                    <polyline points="20 6 9 17 4 12"></polyline>
                </svg>
                <span style="font-size: 40px;">✅</span>
            </div>

            <h1 style="font-size: 2rem; font-weight: 800; color: var(--color-gray-900); margin-bottom: 16px;">Vielen Dank für Ihre Bestellung!</h1>

            <p style="font-size: 1.1rem; color: var(--color-gray-600); margin-bottom: 32px;">
                Ihre Bestellnummer lautet: <strong><?= $v->e($order['order_number']) ?></strong>
            </p>

            <div style="text-align: left; background: var(--color-gray-50); border-radius: var(--radius-md); padding: 24px; margin-bottom: 32px;">
                <h2 style="font-size: 1.1rem; font-weight: 700; margin-bottom: 16px;">Zusammenfassung</h2>
                <div style="display: flex; flex-direction: column; gap: 12px;">
                    <?php foreach($items as $item): ?>
                    <div style="display: flex; justify-content: space-between; font-size: 14px;">
                        <div>
                            <span style="font-weight: 600;"><?= $item['quantity'] ?>x</span>
                            <?= $v->e($item['product_name']) ?>
                        </div>
                        <div style="font-weight: 500;"><?= format_money($item['line_total']) ?></div>
                    </div>
                    <?php endforeach; ?>
                </div>
                <hr style="border: none; border-top: 1px solid var(--color-gray-200); margin: 16px 0;">
                <div style="display: flex; justify-content: space-between; font-weight: 800; font-size: 1.1rem;">
                    <span>Gesamtsumme</span>
                    <span><?= format_money($order['total']) ?></span>
                </div>
            </div>

            <div style="display: flex; gap: 16px; justify-content: center;">
                <a href="<?= $v->url('/account/orders') ?>" class="btn btn--secondary btn--lg">Bestellverlauf</a>
                <a href="<?= $v->url('/') ?>" class="btn btn--primary btn--lg">Weiter einkaufen</a>
            </div>

        </div>
    </div>
</section>
