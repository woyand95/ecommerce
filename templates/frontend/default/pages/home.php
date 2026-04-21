<?php $v->extend('main'); ?>

<!-- Hero Banner -->
<section class="hero hero-banner">
  <div class="container hero-container">
    <h1 class="hero-title">
      Willkommen bei <span class="text-highlight">TechStore</span>
    </h1>
    <p class="hero-subtitle">
      Smartphones, Laptops, Audio & Smart Home –<br>günstig kaufen & schnell geliefert.
    </p>
    <div class="hero-actions">
      <a href="<?= $v->url('/products') ?>" class="btn btn--lg btn--accent">
        Alle Produkte entdecken
      </a>
      <a href="<?= $v->url('/smartphones') ?>" class="btn btn--lg btn--secondary btn--outline-light">
        Smartphones ansehen
      </a>
    </div>
  </div>
</section>

<!-- Category Quick-Links -->
<section class="section-categories">
  <div class="container">
    <h2 class="section-title text-center">Kategorien</h2>
    <div class="category-grid">
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
      <h2 class="section-title">Featured Products</h2>
      <a href="<?= $v->url('/products') ?>" class="link-more">Alle ansehen →</a>
    </div>

    <?php if (empty($featured_products)): ?>
    <div class="empty-state">
      <p class="empty-title">Keine Produkte gefunden. Bitte Datenbank prüfen.</p>
      <p class="empty-subtitle">Seed-Dateien laden: <code>mysql -u root -p ecommerce &lt; database/seeds/seed_all.sql</code></p>
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
<section class="section-usp">
  <div class="container">
    <div class="usp-grid">
      <?php foreach([
        ['🚚','Kostenloser Versand','Ab 49 € Bestellwert'],
        ['↩️','30 Tage Rückgabe','Einfach & unkompliziert'],
        ['🛡️','2 Jahre Garantie','Auf alle Produkte'],
        ['💬','Expertenberatung','Mo–Sa 8–20 Uhr'],
      ] as [$icon, $title, $text]): ?>
      <div class="usp-item">
        <div class="usp-icon"><?= $icon ?></div>
        <div class="usp-title"><?= $title ?></div>
        <div class="usp-text"><?= $text ?></div>
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
