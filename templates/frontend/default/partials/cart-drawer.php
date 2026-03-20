<?php /* Partial: cart-drawer.php */ ?>
<div class="cart-drawer-overlay" id="cartDrawerOverlay" aria-hidden="true"></div>

<div class="cart-drawer"
     id="cartDrawer"
     role="dialog"
     aria-label="<?= $v->t('cart.title') ?>"
     aria-hidden="true">

    <div class="cart-drawer__header">
        <h2 class="cart-drawer__title"><?= $v->t('cart.title') ?></h2>
        <button class="btn btn--ghost btn--icon" id="cartDrawerClose" aria-label="<?= $v->t('cart.close') ?>">
            <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2">
                <line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/>
            </svg>
        </button>
    </div>

    <div class="cart-drawer__body" id="cartDrawerBody">
        <div style="text-align:center;padding:40px 20px;color:#9ca3af">
            <svg width="48" height="48" fill="none" stroke="currentColor" stroke-width="1.5">
                <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>
                <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
            </svg>
            <p style="margin-top:12px;font-size:14px"><?= $v->t('cart.empty') ?></p>
        </div>
    </div>

    <div class="cart-drawer__footer" id="cartDrawerFooter" hidden>
        <div class="cart-totals">
            <div class="cart-total-row">
                <span><?= $v->t('cart.subtotal') ?></span>
                <span class="cart-total-value">—</span>
            </div>
            <div class="cart-total-row">
                <span><?= $v->t('cart.shipping') ?></span>
                <span><?= $v->t('cart.calculated_at_checkout') ?></span>
            </div>
            <div class="cart-total-row total">
                <span><?= $v->t('cart.total') ?></span>
                <strong class="cart-total-value">—</strong>
            </div>
        </div>
        <a href="<?= $v->url('/checkout') ?>" class="btn btn--primary btn--full">
            <?= $v->t('cart.checkout') ?>
            <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"/>
            </svg>
        </a>
        <a href="<?= $v->url('/cart') ?>" class="btn btn--secondary btn--full">
            <?= $v->t('cart.view_cart') ?>
        </a>
    </div>
</div>

<script>
document.getElementById('cartDrawerClose')?.addEventListener('click', () => CartDrawer.close());
</script>
