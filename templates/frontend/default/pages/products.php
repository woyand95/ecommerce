<?php $v->extend('main'); ?>

<div class="container section-products">

  <!-- Page Header -->
  <div class="page-header">
    <h1 class="page-title">
      <?= $v->e($meta_title ?? 'Alle Produkte') ?>
    </h1>
    <?php if (!empty($category['description'])): ?>
    <p class="page-description"><?= $v->e($category['description']) ?></p>
    <?php endif; ?>
  </div>

  <div class="products-layout">

    <!-- Sidebar: Kategorien -->
    <aside class="sidebar">
      <h3 class="sidebar-title">Kategorien</h3>
      <ul class="sidebar-menu">
        <li>
          <a href="<?= $v->url('/products') ?>" class="sidebar-link <?= empty($category) ? 'active' : '' ?>">
            Alle Produkte
          </a>
        </li>
        <?php foreach ($categories ?? [] as $cat): ?>
        <li>
          <a href="<?= $v->url('/category/' . $cat['url_slug']) ?>"
             class="sidebar-link <?= isset($category) && $category['id'] == $cat['id'] ? 'active' : '' ?>">
            <?= $v->e($cat['name']) ?>
          </a>
        </li>
        <?php endforeach; ?>
      </ul>
    </aside>

    <!-- Product Grid -->
    <main class="products-main">
      <?php if (empty($products)): ?>
      <div class="empty-state">
        <div class="empty-icon">📦</div>
        <p class="empty-title">Keine Produkte gefunden</p>
        <p class="empty-subtitle">Für diese Filiale sind noch keine Produkte mit Preisen hinterlegt.</p>
      </div>
      <?php else: ?>
      <div class="products-toolbar">
        <p class="products-count"><?= count($products) ?> Produkte gefunden</p>
      </div>
      <div class="product-grid">
        <?php foreach ($products as $product): ?>
        <?= $v->partial('cards/product-card', ['product' => $product]) ?>
        <?php endforeach; ?>
      </div>
      <?php endif; ?>
    </main>
  </div>
</div>
