<?php $v->extend('main'); ?>

<!-- Hero Banner -->
<section class="hero" style="background:linear-gradient(135deg,#1a56db 0%,#1e40af 100%);color:white;padding:80px 0 60px">
  <div class="container" style="text-align:center">
    <h1 style="font-size:2.75rem;font-weight:800;margin-bottom:16px;line-height:1.15">
      Willkommen bei <span style="color:#fbbf24">TechStore</span>
    </h1>
    <p style="font-size:1.2rem;opacity:.9;max-width:560px;margin:0 auto 32px">
      Smartphones, Laptops, Audio & Smart Home –<br>günstig kaufen & schnell geliefert.
    </p>
    <div style="display:flex;gap:12px;justify-content:center;flex-wrap:wrap">
      <a href="<?= $v->url('/products') ?>" class="btn btn--lg" style="background:#fbbf24;color:#1f2937;border:none;font-weight:700">
        Alle Produkte entdecken
      </a>
      <a href="<?= $v->url('/smartphones') ?>" class="btn btn--lg btn--secondary" style="border-color:rgba(255,255,255,.4);color:white;background:rgba(255,255,255,.1)">
        Smartphones ansehen
      </a>
    </div>
  </div>
</section>

<!-- Category Quick-Links -->
<section style="padding:48px 0 32px;background:#f8fafc">
  <div class="container">
    <h2 class="section-title" style="font-size:1.5rem;font-weight:700;margin-bottom:32px;text-align:center">Kategorien</h2>
    <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(120px,1fr));gap:16px">
      <?php foreach([
        ['📱','Smartphones','/products'],
        ['💻','Laptops','/products'],
        ['🎧','Audio & HiFi','/products'],
        ['📷','Kameras','/products'],
        ['🎮','Gaming','/products'],
        ['🏠','Smart Home','/products'],
        ['📱','Tablets','/products'],
        ['🔌','Zubehör','/products'],
      ] as [$icon, $name, $url]): ?>
      <a href="<?= $v->url($url) ?>" style="display:flex;flex-direction:column;align-items:center;gap:8px;padding:20px 12px;background:white;border:1px solid #e5e7eb;border-radius:12px;text-decoration:none;color:#374151;transition:all .2s;font-size:13px;font-weight:600;text-align:center" onmouseover="this.style.borderColor='#1a56db';this.style.color='#1a56db'" onmouseout="this.style.borderColor='#e5e7eb';this.style.color='#374151'">
        <span style="font-size:2rem"><?= $icon ?></span>
        <?= $v->e($name) ?>
      </a>
      <?php endforeach; ?>
    </div>
  </div>
</section>

<!-- Featured Products -->
<section style="padding:48px 0">
  <div class="container">
    <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:32px">
      <h2 style="font-size:1.75rem;font-weight:700">Featured Products</h2>
      <a href="<?= $v->url('/products') ?>" style="font-size:14px;color:#1a56db;font-weight:600">Alle ansehen →</a>
    </div>

    <?php if (empty($featured_products)): ?>
    <div style="text-align:center;padding:60px;color:#9ca3af">
      <p style="font-size:1.1rem">Keine Produkte gefunden. Bitte Datenbank prüfen.</p>
      <p style="font-size:13px;margin-top:8px">Seed-Dateien laden: <code>mysql -u root -p ecommerce &lt; database/seeds/seed_all.sql</code></p>
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

<!-- USP Banner -->
<section style="background:#1e293b;color:white;padding:48px 0">
  <div class="container">
    <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:32px;text-align:center">
      <?php foreach([
        ['🚚','Kostenloser Versand','Ab 49 € Bestellwert'],
        ['↩️','30 Tage Rückgabe','Einfach & unkompliziert'],
        ['🛡️','2 Jahre Garantie','Auf alle Produkte'],
        ['💬','Expertenberatung','Mo–Sa 8–20 Uhr'],
      ] as [$icon, $title, $text]): ?>
      <div>
        <div style="font-size:2.5rem;margin-bottom:12px"><?= $icon ?></div>
        <div style="font-weight:700;font-size:1rem;margin-bottom:4px"><?= $title ?></div>
        <div style="font-size:13px;opacity:.7"><?= $text ?></div>
      </div>
      <?php endforeach; ?>
    </div>
  </div>
</section>

<!-- Footer -->
<footer class="site-footer">
  <div class="container">
    <div class="footer-grid">
      <div class="footer-brand">
        <span class="footer-logo">TechStore</span>
        <p class="footer-tagline">Ihr Elektronik-Fachhandel mit 5 Filialen in Deutschland & Österreich.</p>
      </div>
      <div>
        <h4 class="footer-heading">Shop</h4>
        <ul class="footer-links">
          <li><a href="<?= $v->url('/products') ?>">Alle Produkte</a></li>
          <li><a href="<?= $v->url('/smartphones') ?>">Smartphones</a></li>
          <li><a href="<?= $v->url('/laptops-notebooks') ?>">Laptops</a></li>
          <li><a href="<?= $v->url('/audio-hifi') ?>">Audio & HiFi</a></li>
        </ul>
      </div>
      <div>
        <h4 class="footer-heading">Service</h4>
        <ul class="footer-links">
          <li><a href="<?= $v->url('/garantie-ruecksendungen') ?>">Garantie & Rückgabe</a></li>
          <li><a href="<?= $v->url('/geschaeftskunden') ?>">Für Unternehmen</a></li>
          <li><a href="<?= $v->url('/kontakt') ?>">Kontakt</a></li>
        </ul>
      </div>
      <div>
        <h4 class="footer-heading">Rechtliches</h4>
        <ul class="footer-links">
          <li><a href="<?= $v->url('/impressum') ?>">Impressum</a></li>
          <li><a href="<?= $v->url('/datenschutz') ?>">Datenschutz</a></li>
          <li><a href="<?= $v->url('/agb') ?>">AGB</a></li>
        </ul>
      </div>
    </div>
    <div class="footer-bottom">
      <span>© <?= date('Y') ?> TechStore GmbH. Alle Rechte vorbehalten.</span>
      <span>Filiale: <strong><?= $v->e($branch['name'] ?? 'Hauptfiliale') ?></strong></span>
    </div>
  </div>
</footer>
