<?php
/**
 * Partial: cards/product-card.php
 * Variables: $product (array), $v (TemplateEngine)
 */
?>
<article class="product-card" itemscope itemtype="https://schema.org/Product">
    <div class="product-card__image-wrap">
        <a href="<?= $v->url('/products/' . $v->e($product['url_slug'])) ?>" tabindex="-1" aria-hidden="true">
            <img class="product-card__image"
                 src="<?= $v->e($product['primary_image'] ?? '/assets/images/placeholder.webp') ?>"
                 alt="<?= $v->e($product['name']) ?>"
                 width="400" height="400"
                 loading="lazy"
                 itemprop="image">
        </a>

        <?php if (!empty($product['sale_price']) && $product['sale_price'] < $product['original_price']): ?>
        <span class="product-card__badge badge--sale" aria-label="<?= $v->t('product.on_sale') ?>">
            -<?= round((1 - $product['sale_price'] / $product['original_price']) * 100) ?>%
        </span>
        <?php endif; ?>

        <?php if ($product['is_featured'] ?? false): ?>
        <span class="product-card__badge badge--new" style="top:2.5rem">
            <?= $v->t('product.featured') ?>
        </span>
        <?php endif; ?>

        <button class="product-card__wishlist"
                data-wishlist="<?= $v->e($product['id']) ?>"
                aria-label="<?= $v->t('wishlist.add', ['name' => $product['name']]) ?>">
            <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/>
            </svg>
        </button>
    </div>

    <div class="product-card__body">
        <p class="product-card__name" itemprop="name">
            <a href="<?= $v->url('/products/' . $v->e($product['url_slug'])) ?>">
                <?= $v->e($product['name']) ?>
            </a>
        </p>

        <div class="product-card__price-row" itemprop="offers" itemscope itemtype="https://schema.org/Offer">
            <meta itemprop="priceCurrency" content="EUR">
            <meta itemprop="price" content="<?= $v->e($product['price']) ?>">

            <?php if (!empty($product['sale_price']) && $product['sale_price'] < $product['original_price']): ?>
            <span class="price price--sale"><?= format_money($product['price']) ?></span>
            <span class="price price--original"><del><?= format_money($product['original_price']) ?></del></span>
            <?php else: ?>
            <span class="price"><?= format_money($product['price']) ?></span>
            <?php endif; ?>

            <?php if (($product['stock_qty'] ?? 0) <= 0 && !($product['allow_backorder'] ?? false)): ?>
            <span class="badge badge--danger" style="font-size:10px"><?= $v->t('product.out_of_stock') ?></span>
            <?php endif; ?>
        </div>

        <button class="btn btn--primary product-card__add"
                data-quick-add="<?= $v->e($product['id']) ?>"
                <?= (($product['stock_qty'] ?? 0) <= 0 && !($product['allow_backorder'] ?? false)) ? 'disabled' : '' ?>>
            <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/><line x1="3" y1="6" x2="23" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/>
            </svg>
            <?= $v->t('cart.add_to_cart') ?>
        </button>
    </div>
</article>
