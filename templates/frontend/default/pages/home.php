<?php $v->extend('main'); ?>

<!-- Modern Hero Banner -->
<section class="hero">
  <div class="container hero-container">
    <h1 class="hero-title">
      Next-Gen Tech, <br>
      <span class="text-highlight">Delivered Today.</span>
    </h1>
    <p class="hero-subtitle">
      Discover the latest smartphones, powerful laptops, and immersive audio gear. Upgrade your life with our premium selection.
    </p>
    <div class="hero-actions">
      <a href="<?= $v->url('/products') ?>" class="btn btn--lg btn--accent">
        Shop Collection
      </a>
      <a href="<?= $v->url('/categories') ?>" class="btn btn--lg btn--outline" style="color: white; border-color: rgba(255,255,255,0.3);">
        Browse Categories
      </a>
    </div>
  </div>
</section>

<!-- Quick Categories -->
<section class="section-categories">
  <div class="container">
    <h2 class="section-title">Shop by Category</h2>
    <div class="category-grid">
      <?php foreach([
        ['📱','Smartphones','/products?category=smartphones'],
        ['💻','Laptops','/products?category=laptops'],
        ['🎧','Audio','/products?category=audio'],
        ['⌚','Wearables','/products?category=wearables'],
        ['🎮','Gaming','/products?category=gaming'],
        ['📷','Cameras','/products?category=cameras'],
        ['🖥️','Monitors','/products?category=monitors'],
        ['🔌','Accessories','/products?category=accessories'],
      ] as [$icon, $name, $url]): ?>
      <a href="<?= $v->url($url) ?>" class="category-card">
        <span class="category-icon"><?= $icon ?></span>
        <span class="category-name"><?= $v->e($name) ?></span>
      </a>
      <?php endforeach; ?>
    </div>
  </div>
</section>

<!-- Featured Products -->
<section class="section-featured">
  <div class="container">
    <div class="section-header">
      <h2 class="section-title">Trending Now</h2>
      <a href="<?= $v->url('/products') ?>" class="link-more">View All Products &rarr;</a>
    </div>

    <?php if (empty($featured_products)): ?>
    <div class="text-center" style="padding: 4rem 0; color: var(--color-gray-500);">
      <p style="font-size: 1.25rem; font-weight: 500; margin-bottom: 0.5rem;">No featured products available.</p>
      <p>Check back later or browse our full catalog.</p>
    </div>
    <?php else: ?>
    <div class="product-grid">
      <?php foreach ($featured_products as $product): ?>
      <?= $v->partial('cards/product-card', ['product' => $product]) ?>
      <?php endforeach; ?>
    </div>
    <?php endif; ?>
  </div>
</section>

<!-- Newsletter / Call to Action -->
<section style="background-color: var(--color-primary-dark); padding: var(--space-16) 0; color: white; text-align: center;">
  <div class="container" style="max-width: 600px;">
    <h2 style="font-size: 2rem; font-weight: 700; margin-bottom: var(--space-4);">Join the TechStore Community</h2>
    <p style="color: var(--color-gray-300); margin-bottom: var(--space-8);">Subscribe to our newsletter for exclusive deals, early access to new products, and tech tips.</p>
    <form style="display: flex; gap: var(--space-2); flex-wrap: wrap; justify-content: center;" onsubmit="event.preventDefault(); alert('Subscribed!');">
      <input type="email" placeholder="Enter your email address" required style="padding: 0.75rem 1rem; border-radius: var(--radius-md); border: none; flex: 1; min-width: 250px;">
      <button type="submit" class="btn btn--accent">Subscribe</button>
    </form>
  </div>
</section>
