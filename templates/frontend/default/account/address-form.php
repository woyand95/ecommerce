<?php clone $v; $v->extend('main'); ?>
<?php $v->section('account_content'); ?>

<div style="margin-bottom: 32px;">
    <h1 style="font-size: 1.75rem; font-weight: 800; color: var(--color-gray-900);"><?= isset($address) ? 'Adresse bearbeiten' : 'Neue Adresse' ?></h1>
    <a href="<?= $v->url('/account/addresses') ?>" style="display: inline-block; color: var(--color-primary); font-weight: 600; text-decoration: none; margin-top: 8px;">&larr; Zurück zu Adressen</a>
</div>

<?php if (isset($error)): ?>
    <div style="background: var(--color-danger-light); color: var(--color-danger); padding: 16px; border-radius: var(--radius-md); margin-bottom: 24px; font-weight: 500;">
        <?= $v->e($error) ?>
    </div>
<?php endif; ?>

<div style="background: white; border: 1px solid var(--color-gray-200); border-radius: var(--radius-lg); padding: 32px;">
    <form action="<?= isset($address) ? $v->url('/account/addresses/' . $address['id'] . '/edit') : $v->url('/account/addresses/create') ?>" method="POST" style="display: grid; gap: 24px;">
        <input type="hidden" name="csrf_token" value="<?= csrf_token() ?>">

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px;">
            <div>
                <label style="display: block; font-size: 14px; font-weight: 600; color: var(--color-gray-700); margin-bottom: 8px;">Adresstyp</label>
                <select name="type" required style="width: 100%; padding: 12px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-family: inherit; font-size: 15px; color: var(--color-gray-900); background-color: white; outline: none;">
                    <option value="shipping" <?= (isset($address) && $address['type'] === 'shipping') ? 'selected' : '' ?>>Lieferadresse</option>
                    <option value="billing" <?= (isset($address) && $address['type'] === 'billing') ? 'selected' : '' ?>>Rechnungsadresse</option>
                </select>
            </div>

            <div style="display: flex; align-items: center; padding-top: 28px;">
                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
                    <input type="checkbox" name="is_default" value="1" <?= (isset($address) && $address['is_default']) ? 'checked' : '' ?> style="width: 18px; height: 18px; accent-color: var(--color-primary);">
                    <span style="font-size: 15px; font-weight: 500; color: var(--color-gray-800);">Als Standardadresse festlegen</span>
                </label>
            </div>
        </div>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px;">
            <div>
                <label style="display: block; font-size: 14px; font-weight: 600; color: var(--color-gray-700); margin-bottom: 8px;">Vorname</label>
                <input type="text" name="first_name" value="<?= $v->e($address['first_name'] ?? '') ?>" required style="width: 100%; padding: 12px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-family: inherit; font-size: 15px; color: var(--color-gray-900); outline: none;">
            </div>
            <div>
                <label style="display: block; font-size: 14px; font-weight: 600; color: var(--color-gray-700); margin-bottom: 8px;">Nachname</label>
                <input type="text" name="last_name" value="<?= $v->e($address['last_name'] ?? '') ?>" required style="width: 100%; padding: 12px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-family: inherit; font-size: 15px; color: var(--color-gray-900); outline: none;">
            </div>
        </div>

        <div>
            <label style="display: block; font-size: 14px; font-weight: 600; color: var(--color-gray-700); margin-bottom: 8px;">Firma (optional)</label>
            <input type="text" name="company" value="<?= $v->e($address['company'] ?? '') ?>" style="width: 100%; padding: 12px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-family: inherit; font-size: 15px; color: var(--color-gray-900); outline: none;">
        </div>

        <div>
            <label style="display: block; font-size: 14px; font-weight: 600; color: var(--color-gray-700); margin-bottom: 8px;">Straße und Hausnummer</label>
            <input type="text" name="street" value="<?= $v->e($address['street'] ?? $address['address_line1'] ?? '') ?>" required style="width: 100%; padding: 12px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-family: inherit; font-size: 15px; color: var(--color-gray-900); outline: none;">
        </div>

        <div style="display: grid; grid-template-columns: 1fr 2fr; gap: 24px;">
            <div>
                <label style="display: block; font-size: 14px; font-weight: 600; color: var(--color-gray-700); margin-bottom: 8px;">PLZ</label>
                <input type="text" name="postal_code" value="<?= $v->e($address['postal_code'] ?? '') ?>" required style="width: 100%; padding: 12px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-family: inherit; font-size: 15px; color: var(--color-gray-900); outline: none;">
            </div>
            <div>
                <label style="display: block; font-size: 14px; font-weight: 600; color: var(--color-gray-700); margin-bottom: 8px;">Stadt</label>
                <input type="text" name="city" value="<?= $v->e($address['city'] ?? '') ?>" required style="width: 100%; padding: 12px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-family: inherit; font-size: 15px; color: var(--color-gray-900); outline: none;">
            </div>
        </div>

        <div>
            <label style="display: block; font-size: 14px; font-weight: 600; color: var(--color-gray-700); margin-bottom: 8px;">Land</label>
            <input type="text" name="country_code" value="<?= $v->e($address['country_code'] ?? 'DE') ?>" required style="width: 100%; padding: 12px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-family: inherit; font-size: 15px; color: var(--color-gray-900); outline: none;">
        </div>

        <div style="display: flex; justify-content: flex-end; margin-top: 16px;">
            <button type="submit" style="background: var(--color-primary); color: white; border: none; padding: 14px 32px; border-radius: var(--radius-md); font-weight: 600; font-size: 15px; cursor: pointer; transition: background 0.2s; outline: none;" onmouseover="this.style.background='var(--color-primary-dark)'" onmouseout="this.style.background='var(--color-primary)'">
                Adresse speichern
            </button>
        </div>
    </form>
</div>

<?php $v->endSection(); ?>
<?php require __DIR__ . '/layout.php'; ?>
