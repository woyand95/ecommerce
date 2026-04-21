<?php clone $v; $v->extend('main'); ?>
<?php $v->section('account_content'); ?>

<h1 style="font-size: 1.75rem; font-weight: 800; margin-bottom: 32px; color: var(--color-gray-900);">Meine Bestellungen</h1>

<?php if (empty($orders)): ?>
    <div style="text-align: center; padding: 64px 24px; color: var(--color-gray-500); background: var(--color-gray-50); border-radius: var(--radius-md); border: 1px dashed var(--color-gray-300);">
        <div style="font-size: 3rem; margin-bottom: 16px;">📦</div>
        <p style="font-size: 1.1rem; font-weight: 600; color: var(--color-gray-700);">Sie haben noch keine Bestellungen getätigt.</p>
        <a href="<?= $v->url('/products') ?>" class="btn btn--primary" style="margin-top: 16px;">Jetzt einkaufen</a>
    </div>
<?php else: ?>
    <div style="display: flex; flex-direction: column; gap: 16px;">
        <?php foreach ($orders as $order): ?>
        <div style="border: 1px solid var(--color-gray-200); border-radius: var(--radius-md); padding: 24px; display: flex; justify-content: space-between; align-items: center; transition: box-shadow 0.2s;" onmouseover="this.style.boxShadow='var(--shadow-md)'" onmouseout="this.style.boxShadow='none'">
            <div style="display: flex; flex-direction: column; gap: 8px;">
                <div style="font-size: 1.1rem; font-weight: 700; color: var(--color-primary);"><?= $v->e($order['order_number']) ?></div>
                <div style="font-size: 14px; color: var(--color-gray-600);">
                    Datum: <?= date('d.m.Y H:i', strtotime($order['created_at'])) ?>
                </div>
                <div style="display: flex; align-items: center; gap: 12px; margin-top: 8px;">
                    <span style="font-weight: 600; color: var(--color-gray-900);"><?= format_money($order['total']) ?></span>
                    <span style="font-size: 12px; padding: 4px 8px; border-radius: 4px; background: <?= $order['status'] === 'delivered' ? 'var(--color-success-light)' : 'var(--color-warning-light)' ?>; color: <?= $order['status'] === 'delivered' ? 'var(--color-success)' : 'var(--color-warning)' ?>; font-weight: 600; text-transform: uppercase;">
                        <?= $v->e($order['status_label']) ?>
                    </span>
                </div>
            </div>
            <div>
                <a href="<?= $v->url('/account/orders/' . $order['id']) ?>" class="btn btn--secondary">Details anzeigen</a>
            </div>
        </div>
        <?php endforeach; ?>
    </div>
<?php endif; ?>

<?php $v->endSection(); ?>
<?php require __DIR__ . '/layout.php'; ?>
