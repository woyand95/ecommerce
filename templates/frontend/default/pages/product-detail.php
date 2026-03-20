<?php $v->extend('main'); ?>
<?php $v->section('head_styles'); ?>
<link rel="stylesheet" href="<?= $v->asset('css/product-detail.css') ?>">
<?php $v->endSection(); ?>

<section class="product-detail" itemscope itemtype="https://schema.org/Product">

    <div class="container product-detail__inner">

        <!-- ── Gallery ─────────────────────────────────────── -->
        <div class="product-gallery" data-gallery>
            <div class="product-gallery__main">
                <?php $primaryImg = $product['images'][0] ?? null; ?>
                <img id="mainImage"
                     src="<?= $v->e($primaryImg['file_path'] ?? '/assets/img/placeholder.webp') ?>"
                     alt="<?= $v->e($product['name']) ?>"
                     width="600" height="600"
                     loading="eager"
                     itemprop="image"
                     class="product-gallery__main-img">
                <button class="gallery-zoom" aria-label="<?= $v->t('product.zoom') ?>">
                    <svg width="20" height="20" aria-hidden="true">
                        <use href="<?= $v->asset('icons/sprite.svg') ?>#zoom-in"></use>
                    </svg>
                </button>
            </div>
            <?php if (count($product['images']) > 1): ?>
            <div class="product-gallery__thumbs" role="list">
                <?php foreach ($product['images'] as $i => $img): ?>
                <button class="gallery-thumb <?= $i === 0 ? 'active' : '' ?>"
                        data-src="<?= $v->e($img['file_path']) ?>"
                        role="listitem"
                        aria-label="<?= $v->t('product.image_n', ['n' => $i + 1]) ?>"
                        aria-current="<?= $i === 0 ? 'true' : 'false' ?>">
                    <img src="<?= $v->e($img['file_path']) ?>"
                         alt="" width="80" height="80" loading="lazy">
                </button>
                <?php endforeach; ?>
            </div>
            <?php endif; ?>
        </div>

        <!-- ── Info ───────────────────────────────────────── -->
        <div class="product-info">
            <!-- Breadcrumb -->
            <nav class="breadcrumb" aria-label="<?= $v->t('nav.breadcrumb') ?>">
                <a href="<?= $v->url('/') ?>"><?= $v->t('nav.home') ?></a>
                <span aria-hidden="true">/</span>
                <?php if (!empty($product['category_name'])): ?>
                <a href="<?= $v->url('/category/' . $v->e($product['category_slug'] ?? '')) ?>">
                    <?= $v->e($product['category_name']) ?>
                </a>
                <span aria-hidden="true">/</span>
                <?php endif; ?>
                <span aria-current="page" itemprop="name"><?= $v->e($product['name']) ?></span>
            </nav>

            <h1 class="product-title" itemprop="name"><?= $v->e($product['name']) ?></h1>
            <p class="product-sku"><?= $v->t('product.sku') ?>: <code><?= $v->e($product['sku']) ?></code></p>

            <!-- Price block -->
            <div class="product-price" itemprop="offers" itemscope itemtype="https://schema.org/Offer">
                <meta itemprop="priceCurrency" content="<?= $v->e($branch['currency_code']) ?>">
                <meta itemprop="price"         content="<?= $v->e($product['price']) ?>">

                <?php if (!empty($product['sale_price']) && $product['sale_price'] < $product['original_price']): ?>
                <span class="price price--sale" aria-label="<?= $v->t('product.sale_price') ?>">
                    <?= format_money($product['price'], $branch['currency_code']) ?>
                </span>
                <span class="price price--original">
                    <del><?= format_money($product['original_price'], $branch['currency_code']) ?></del>
                </span>
                <span class="badge badge--sale">
                    -<?= round((1 - $product['price'] / $product['original_price']) * 100) ?>%
                </span>
                <?php else: ?>
                <span class="price" aria-label="<?= $v->t('product.price') ?>">
                    <?= format_money($product['price'], $branch['currency_code']) ?>
                </span>
                <?php endif; ?>

                <!-- Stock badge -->
                <?php if ($product['stock_qty'] > 0): ?>
                <span class="stock-badge stock-badge--in" itemprop="availability"
                      content="https://schema.org/InStock">
                    ✓ <?= $v->t('product.in_stock') ?>
                </span>
                <?php elseif ($product['allow_backorder']): ?>
                <span class="stock-badge stock-badge--backorder">
                    <?= $v->t('product.available_on_backorder') ?>
                </span>
                <?php else: ?>
                <span class="stock-badge stock-badge--out" itemprop="availability"
                      content="https://schema.org/OutOfStock">
                    <?= $v->t('product.out_of_stock') ?>
                </span>
                <?php endif; ?>
            </div>

            <p class="product-short-description"><?= $v->e($product['short_description']) ?></p>

            <!-- ── Variant selector ──────────────────────── -->
            <?php if ($product['type'] === 'variable' && !empty($product['variants'])): ?>
            <div class="variant-selector" id="variantSelector">
                <p class="variant-label"><?= $v->t('product.select_variant') ?>:</p>
                <div class="variant-options" role="group" aria-label="<?= $v->t('product.variants') ?>">
                    <?php foreach ($product['variants'] as $variant): ?>
                    <button class="variant-btn <?= !$variant['stock_qty'] && !$variant['allow_backorder'] ? 'out-of-stock' : '' ?>"
                            data-variant-id="<?= $v->e($variant['id']) ?>"
                            data-price="<?= $v->e($variant['price']) ?>"
                            data-stock="<?= $v->e($variant['stock_qty']) ?>"
                            aria-pressed="false"
                            <?= !$variant['stock_qty'] && !$variant['allow_backorder'] ? 'disabled aria-disabled="true"' : '' ?>>
                        <?php
                            $attrs = is_string($variant['attributes'])
                                ? json_decode($variant['attributes'], true)
                                : $variant['attributes'];
                            echo $v->e(implode(' / ', $attrs ?? []));
                        ?>
                    </button>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php endif; ?>

            <!-- ── Add to Cart ───────────────────────────── -->
            <form class="add-to-cart-form" id="addToCartForm"
                  data-product-id="<?= $v->e($product['id']) ?>"
                  data-branch-id="<?= $v->e($branch['id']) ?>"
                  novalidate>
                <input type="hidden" name="csrf_token" value="<?= $v->e($csrf_token) ?>">
                <input type="hidden" name="product_id"  value="<?= $v->e($product['id']) ?>" id="inputProductId">
                <input type="hidden" name="variant_id"  value="" id="inputVariantId">

                <div class="qty-add-row">
                    <label class="qty-label" for="qtyInput"><?= $v->t('cart.quantity') ?></label>
                    <div class="qty-stepper" role="group">
                        <button type="button" class="qty-dec" aria-label="<?= $v->t('cart.decrease_qty') ?>">−</button>
                        <input type="number" id="qtyInput" name="quantity"
                               value="1" min="1" max="<?= (int) ($product['stock_qty'] ?: 999) ?>"
                               class="qty-input" aria-label="<?= $v->t('cart.quantity') ?>">
                        <button type="button" class="qty-inc" aria-label="<?= $v->t('cart.increase_qty') ?>">+</button>
                    </div>

                    <button type="submit"
                            class="btn btn--primary btn--lg add-to-cart-btn"
                            <?= (!$product['stock_qty'] && !$product['allow_backorder']) ? 'disabled' : '' ?>>
                        <svg width="18" height="18" aria-hidden="true">
                            <use href="<?= $v->asset('icons/sprite.svg') ?>#shopping-cart"></use>
                        </svg>
                        <?= $v->t('cart.add_to_cart') ?>
                    </button>
                </div>

                <!-- Delivery options (based on branch settings) -->
                <div class="delivery-options">
                    <?php if ($branch['allows_shipping'] ?? true): ?>
                    <span class="delivery-badge">
                        🚚 <?= $v->t('delivery.shipping_available') ?>
                    </span>
                    <?php endif; ?>
                    <?php if ($branch['allows_pickup'] ?? true): ?>
                    <span class="delivery-badge">
                        🏪 <?= $v->t('delivery.pickup_available') ?>
                    </span>
                    <?php endif; ?>
                </div>
            </form>

            <!-- ── Description tabs ──────────────────────── -->
            <div class="product-tabs" role="tablist" aria-label="<?= $v->t('product.info') ?>">
                <button role="tab" aria-selected="true" aria-controls="tab-desc" id="btn-desc">
                    <?= $v->t('product.description') ?>
                </button>
                <button role="tab" aria-selected="false" aria-controls="tab-specs" id="btn-specs"
                        tabindex="-1">
                    <?= $v->t('product.specifications') ?>
                </button>
            </div>
            <div id="tab-desc" role="tabpanel" aria-labelledby="btn-desc" class="tab-panel">
                <div class="product-description" itemprop="description">
                    <?= $product['description'] /* Trusted HTML from CMS */ ?>
                </div>
            </div>
            <div id="tab-specs" role="tabpanel" aria-labelledby="btn-specs" class="tab-panel" hidden>
                <dl class="specs-list">
                    <?php if ($product['weight']): ?>
                    <dt><?= $v->t('product.weight') ?></dt>
                    <dd><?= $v->e($product['weight']) ?> kg</dd>
                    <?php endif; ?>
                    <dt>SKU</dt><dd><?= $v->e($product['sku']) ?></dd>
                </dl>
            </div>
        </div>
    </div>

    <!-- ── Related products ──────────────────────────────── -->
    <?php if (!empty($related_products)): ?>
    <section class="related-products" aria-label="<?= $v->t('product.related') ?>">
        <div class="container">
            <h2 class="section-title"><?= $v->t('product.you_may_also_like') ?></h2>
            <div class="product-grid">
                <?php foreach ($related_products as $related): ?>
                <?= $v->partial('cards/product-card', ['product' => $related]) ?>
                <?php endforeach; ?>
            </div>
        </div>
    </section>
    <?php endif; ?>

</section>

<?php $v->section('foot_scripts'); ?>
<script src="<?= $v->asset('js/product-detail.js') ?>" defer></script>
<?php $v->endSection(); ?>
