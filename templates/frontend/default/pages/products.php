<?php $v->extend('main'); ?>

<div class="container" style="padding-top:32px;padding-bottom:64px">

  <!-- Page Header -->
  <div style="margin-bottom:32px">
    <h1 style="font-size:2rem;font-weight:800;color:#111827">
      <?= $v->e($meta_title ?? 'Alle Produkte') ?>
    </h1>
    <?php if (!empty($category['description'])): ?>
    <p style="color:#6b7280;margin-top:8px"><?= $v->e($category['description']) ?></p>
    <?php endif; ?>
  </div>

  <div style="display:grid;grid-template-columns:220px 1fr;gap:32px;align-items:start">

    <!-- Sidebar: Kategorien -->
    <aside style="background:white;border:1px solid #e5e7eb;border-radius:12px;padding:20px;position:sticky;top:80px">
      <h3 style="font-size:14px;font-weight:700;text-transform:uppercase;letter-spacing:.05em;color:#6b7280;margin-bottom:16px">Kategorien</h3>
      <ul style="display:flex;flex-direction:column;gap:4px">
        <li>
          <a href="<?= $v->url('/products') ?>" style="display:block;padding:8px 10px;border-radius:8px;font-size:14px;color:#374151;text-decoration:none;<?= empty($category) ? 'background:#eff6ff;color:#1a56db;font-weight:600' : '' ?>">
            Alle Produkte
          </a>
        </li>
        <?php foreach ($categories ?? [] as $cat): ?>
        <li>
          <a href="<?= $v->url('/category/' . $cat['url_slug']) ?>"
             style="display:block;padding:8px 10px;border-radius:8px;font-size:14px;color:#374151;text-decoration:none;<?= isset($category) && $category['id'] == $cat['id'] ? 'background:#eff6ff;color:#1a56db;font-weight:600' : '' ?>"
             onmouseover="this.style.background='#f3f4f6'" onmouseout="this.style.background='<?= isset($category) && $category['id'] == $cat['id'] ? '#eff6ff' : 'transparent' ?>'">
            <?= $v->e($cat['name']) ?>
          </a>
        </li>
        <?php endforeach; ?>
      </ul>
    </aside>

    <!-- Product Grid -->
    <main>
      <?php if (empty($products)): ?>
      <div style="text-align:center;padding:80px 20px;color:#9ca3af">
        <div style="font-size:3rem;margin-bottom:16px">📦</div>
        <p style="font-size:1.1rem;font-weight:600">Keine Produkte gefunden</p>
        <p style="font-size:14px;margin-top:8px">Für diese Filiale sind noch keine Produkte mit Preisen hinterlegt.</p>
      </div>
      <?php else: ?>
      <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:20px">
        <p style="font-size:14px;color:#6b7280"><?= count($products) ?> Produkte gefunden</p>
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
