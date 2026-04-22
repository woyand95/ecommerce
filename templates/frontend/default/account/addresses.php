<?php clone $v; $v->extend('main'); ?>
<?php $v->section('account_content'); ?>

<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 32px;">
    <div>
        <h1 style="font-size: 1.75rem; font-weight: 800; color: var(--color-gray-900);">Meine Adressen</h1>
        <p style="color: var(--color-gray-500); margin-top: 8px;">Verwalten Sie Ihre Liefer- und Rechnungsadressen.</p>
    </div>
    <a href="<?= $v->url('/account/addresses/create') ?>" style="display: inline-block; background: var(--color-primary); color: white; padding: 10px 20px; border-radius: var(--radius-md); font-weight: 600; text-decoration: none; transition: background 0.2s;" onmouseover="this.style.background='var(--color-primary-dark)'" onmouseout="this.style.background='var(--color-primary)'">+ Neue Adresse</a>
</div>

<?php if (isset($success)): ?>
    <div style="background: var(--color-success-light); color: var(--color-success); padding: 16px; border-radius: var(--radius-md); margin-bottom: 24px; font-weight: 500;">
        <?= $v->e($success) ?>
    </div>
<?php endif; ?>

<div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 24px;">
    <?php if (empty($addresses)): ?>
        <div style="grid-column: 1 / -1; text-align: center; padding: 48px 24px; background: white; border: 1px dashed var(--color-gray-300); border-radius: var(--radius-lg);">
            <div style="font-size: 48px; margin-bottom: 16px; opacity: 0.5;">📍</div>
            <h3 style="font-size: 1.25rem; font-weight: 600; color: var(--color-gray-900); margin-bottom: 8px;">Keine Adressen gefunden</h3>
            <p style="color: var(--color-gray-500);">Sie haben noch keine Adressen in Ihrem Profil gespeichert.</p>
        </div>
    <?php else: ?>
        <?php foreach ($addresses as $address): ?>
            <div style="background: white; border: 1px solid <?= $address['is_default'] ? 'var(--color-primary)' : 'var(--color-gray-200)' ?>; border-radius: var(--radius-lg); padding: 24px; position: relative;">
                <?php if ($address['is_default']): ?>
                    <div style="position: absolute; top: 0; right: 24px; transform: translateY(-50%); background: var(--color-primary); color: white; font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; padding: 4px 12px; border-radius: 9999px;">
                        Standard
                    </div>
                <?php endif; ?>

                <div style="display: flex; gap: 8px; margin-bottom: 16px;">
                    <span style="font-size: 12px; font-weight: 600; background: var(--color-gray-100); color: var(--color-gray-600); padding: 4px 8px; border-radius: 4px; text-transform: uppercase;">
                        <?= $v->e($address['type'] === 'shipping' ? 'Lieferadresse' : 'Rechnungsadresse') ?>
                    </span>
                </div>

                <div style="font-weight: 700; font-size: 1.1rem; color: var(--color-gray-900); margin-bottom: 4px;">
                    <?= $v->e($address['first_name'] . ' ' . $address['last_name']) ?>
                </div>

                <?php if (!empty($address['company'])): ?>
                    <div style="color: var(--color-gray-700); margin-bottom: 4px;"><?= $v->e($address['company']) ?></div>
                <?php endif; ?>

                <div style="color: var(--color-gray-600); line-height: 1.6; margin-bottom: 24px;">
                    <?= $v->e($address['street'] ?? $address['address_line1'] ?? '') ?><br>
                    <?= $v->e($address['postal_code'] . ' ' . $address['city']) ?><br>
                    <?= $v->e($address['country_code']) ?>
                </div>

                <div style="display: flex; gap: 16px; border-top: 1px solid var(--color-gray-100); padding-top: 16px;">
                    <a href="<?= $v->url('/account/addresses/' . $address['id'] . '/edit') ?>" style="color: var(--color-primary); text-decoration: none; font-weight: 600; font-size: 14px;">Bearbeiten</a>
                    <form action="<?= $v->url('/account/addresses/' . $address['id'] . '/delete') ?>" method="POST" style="margin: 0;" onsubmit="return confirm('Möchten Sie diese Adresse wirklich löschen?');">
                        <input type="hidden" name="csrf_token" value="<?= csrf_token() ?>">
                        <button type="submit" style="background: none; border: none; color: var(--color-danger); font-weight: 600; font-size: 14px; cursor: pointer; padding: 0;">Löschen</button>
                    </form>
                </div>
            </div>
        <?php endforeach; ?>
    <?php endif; ?>
</div>

<?php $v->endSection(); ?>
<?php require __DIR__ . '/layout.php'; ?>
