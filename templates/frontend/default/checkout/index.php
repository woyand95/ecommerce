<?php $v->extend('main'); ?>

<section class="section-checkout" style="padding: 48px 0; background: var(--color-gray-50); min-height: 80vh;">
    <div class="container">
        <h1 style="font-size: 2rem; font-weight: 800; margin-bottom: 32px;">Kasse</h1>

        <?php if ($error = session_get_flash('error')): ?>
            <div style="background:#fee2e2;color:#ef4444;padding:16px;border-radius:8px;margin-bottom:24px;border:1px solid #f87171;">
                <?= $v->e($error) ?>
            </div>
        <?php endif; ?>

        <div style="display: grid; grid-template-columns: 1fr; gap: 32px;">
            <style>
                @media (min-width: 1024px) {
                    .checkout-grid { grid-template-columns: 1.5fr 1fr !important; }
                }
            </style>

            <form action="<?= $v->url('/checkout/place-order') ?>" method="POST" id="checkoutForm" class="checkout-grid" style="display: grid; grid-template-columns: 1fr; gap: 32px; align-items: start;">
                <input type="hidden" name="csrf_token" value="<?= $v->e($csrf_token) ?>">

                <div class="checkout-form-sections" style="display: flex; flex-direction: column; gap: 32px;">

                    <!-- 1. Address -->
                    <div style="background: white; border: 1px solid var(--color-gray-200); border-radius: var(--radius-lg); padding: 24px;">
                        <h2 style="font-size: 1.25rem; font-weight: 700; margin-bottom: 16px;">1. Lieferadresse</h2>
                        <?php if (empty($addresses)): ?>
                            <p style="color: var(--color-gray-500); font-size: 14px; margin-bottom: 16px;">Bitte fügen Sie in Ihrem Konto eine Adresse hinzu.</p>
                            <a href="<?= $v->url('/account/addresses') ?>" class="btn btn--secondary">Adresse hinzufügen</a>
                        <?php else: ?>
                            <div style="display: flex; flex-direction: column; gap: 12px;">
                                <?php foreach ($addresses as $addr): ?>
                                <label style="display: flex; gap: 12px; padding: 16px; border: 1px solid var(--color-gray-200); border-radius: var(--radius-md); cursor: pointer; transition: all 0.2s;" class="address-label">
                                    <input type="radio" name="address_id" value="<?= $v->e($addr['id']) ?>" required <?= $addr['is_default_shipping'] ? 'checked' : '' ?> style="margin-top: 4px;">
                                    <div>
                                        <div style="font-weight: 600; margin-bottom: 4px;"><?= $v->e($addr['first_name'] . ' ' . $addr['last_name']) ?></div>
                                        <div style="font-size: 14px; color: var(--color-gray-600);">
                                            <?= $v->e($addr['street']) ?><br>
                                            <?= $v->e($addr['postal_code'] . ' ' . $addr['city']) ?><br>
                                            <?= $v->e($addr['country_code']) ?>
                                        </div>
                                    </div>
                                </label>
                                <?php endforeach; ?>
                            </div>
                        <?php endif; ?>
                    </div>

                    <!-- 2. Payment -->
                    <div style="background: white; border: 1px solid var(--color-gray-200); border-radius: var(--radius-lg); padding: 24px;">
                        <h2 style="font-size: 1.25rem; font-weight: 700; margin-bottom: 16px;">2. Zahlungsart</h2>
                        <div style="display: flex; flex-direction: column; gap: 12px;">
                            <?php foreach ($paymentMethods as $index => $pm): ?>
                            <label style="display: flex; gap: 12px; padding: 16px; border: 1px solid var(--color-gray-200); border-radius: var(--radius-md); cursor: pointer;">
                                <input type="radio" name="payment_method" value="<?= $v->e($pm['id']) ?>" required <?= $index === 0 ? 'checked' : '' ?> style="margin-top: 4px;">
                                <span style="font-weight: 500;"><?= $v->e($pm['name']) ?></span>
                            </label>
                            <?php endforeach; ?>
                        </div>
                    </div>
                </div>

                <!-- 3. Summary & Submit -->
                <div style="background: white; border: 1px solid var(--color-gray-200); border-radius: var(--radius-lg); padding: 24px; position: sticky; top: 80px;">
                    <h2 style="font-size: 1.25rem; font-weight: 700; margin-bottom: 24px;">Zusammenfassung</h2>

                    <div style="display: flex; flex-direction: column; gap: 16px; margin-bottom: 24px;">
                        <?php foreach ($items as $item): ?>
                        <div style="display: flex; justify-content: space-between; font-size: 14px;">
                            <div style="flex: 1; padding-right: 16px;">
                                <div style="font-weight: 500;"><?= $v->e($item['quantity']) ?>x <?= $v->e($item['name']) ?></div>
                            </div>
                            <div style="font-weight: 500;"><?= format_money($item['line_total']) ?></div>
                        </div>
                        <?php endforeach; ?>
                    </div>

                    <hr style="border: none; border-top: 1px solid var(--color-gray-200); margin-bottom: 16px;">

                    <div style="display: flex; flex-direction: column; gap: 12px; margin-bottom: 24px; font-size: 14px;">
                        <div style="display: flex; justify-content: space-between;">
                            <span style="color: var(--color-gray-600);">Zwischensumme</span>
                            <span style="font-weight: 500;"><?= format_money($subtotal) ?></span>
                        </div>
                        <div style="display: flex; justify-content: space-between;">
                            <span style="color: var(--color-gray-600);">Versand</span>
                            <span style="font-weight: 500;"><?= $shipping_cost == 0 ? 'Kostenlos' : format_money($shipping_cost) ?></span>
                        </div>
                        <div style="display: flex; justify-content: space-between; font-size: 1.25rem; font-weight: 800; margin-top: 8px; padding-top: 16px; border-top: 1px dashed var(--color-gray-200);">
                            <span>Gesamtsumme</span>
                            <span><?= format_money($total) ?></span>
                        </div>
                    </div>

                    <button type="submit" class="btn btn--primary btn--full btn--lg" <?= empty($addresses) ? 'disabled' : '' ?>>
                        Jetzt kostenpflichtig bestellen
                    </button>

                    <p style="font-size: 12px; color: var(--color-gray-500); text-align: center; margin-top: 16px;">
                        Mit Ihrer Bestellung erklären Sie sich mit unseren <a href="<?= $v->url('/agb') ?>">AGB</a> und <a href="<?= $v->url('/datenschutz') ?>">Datenschutzbestimmungen</a> einverstanden.
                    </p>
                </div>
            </form>
        </div>
    </div>
</section>

<script>
    document.querySelectorAll('input[name="address_id"]').forEach(radio => {
        radio.addEventListener('change', e => {
            document.querySelectorAll('.address-label').forEach(l => l.style.borderColor = 'var(--color-gray-200)');
            if (e.target.checked) {
                e.target.closest('label').style.borderColor = 'var(--color-primary)';
            }
        });
    });
</script>
