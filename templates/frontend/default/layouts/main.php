<!DOCTYPE html>
<html lang="<?= $v->e($lang->getCurrent()) ?>" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <!-- SEO Meta -->
    <title><?= $v->e($meta_title ?? config('app.name')) ?></title>
    <?php if (!empty($meta_description)): ?>
    <meta name="description" content="<?= $v->e($meta_description) ?>">
    <?php endif; ?>
    <meta name="robots" content="<?= $v->e($meta_robots ?? 'index,follow') ?>">
    <link rel="canonical" href="<?= $v->e($canonical_url ?? $v->url(request_path())) ?>">

    <!-- Open Graph -->
    <meta property="og:title"       content="<?= $v->e($meta_title ?? config('app.name')) ?>">
    <meta property="og:description" content="<?= $v->e($meta_description ?? '') ?>">
    <meta property="og:type"        content="website">
    <meta property="og:url"         content="<?= $v->e($canonical_url ?? '') ?>">
    <?php if (!empty($og_image)): ?>
    <meta property="og:image"       content="<?= $v->e($og_image) ?>">
    <?php endif; ?>

    <!-- Alternate language URLs -->
    <?php foreach (active_languages() as $altLang): ?>
    <link rel="alternate" hreflang="<?= $v->e($altLang['code']) ?>"
          href="/<?= $v->e($altLang['code']) ?><?= $v->e(request_path()) ?>">
    <?php endforeach; ?>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Styles -->
    <link rel="stylesheet" href="<?= $v->asset('css/app.css') ?>">
    <?= $v->yield('head_styles') ?>

    <!-- Structured data -->
    <?php if (!empty($structured_data)): ?>
    <script type="application/ld+json"><?= json_encode($structured_data, JSON_UNESCAPED_UNICODE) ?></script>
    <?php endif; ?>

    <!-- CSRF token for JS requests -->
    <meta name="csrf-token" content="<?= $v->e($csrf_token) ?>">

    <!-- Branch identity -->
    <meta name="branch" content="<?= $v->e($branch['slug'] ?? '') ?>">
</head>
<body class="branch-<?= $v->e($branch['slug'] ?? 'default') ?> lang-<?= $v->e($lang->getCurrent()) ?>">

<!-- Skip to content (accessibility) -->
<a class="sr-only" href="#main-content"><?= $v->t('layout.skip_to_content') ?></a>

<!-- ═══ HEADER ═══════════════════════════════════════════════ -->
<?= $v->partial('header', ['branch' => $branch]) ?>

<!-- ═══ FLASH MESSAGES ══════════════════════════════════════ -->
<?= $v->partial('flash-messages') ?>

<!-- ═══ MAIN CONTENT ════════════════════════════════════════ -->
<main id="main-content" class="main-content" role="main">
    <?= $content ?>
</main>

<!-- ═══ FOOTER ══════════════════════════════════════════════ -->
<footer class="site-footer">
  <div class="container">
    <div class="footer-grid">
      <div class="footer-brand">
        <span class="footer-logo">TechStore</span>
        <p>Premium electronics and accessories with next-day delivery. Discover our curated collection of top-tier gadgets.</p>
      </div>

      <div>
        <h4 class="footer-heading">Shop</h4>
        <ul class="footer-links">
          <li><a href="<?= $v->url('/products') ?>">All Products</a></li>
          <li><a href="<?= $v->url('/smartphones') ?>">Smartphones</a></li>
          <li><a href="<?= $v->url('/laptops') ?>">Laptops</a></li>
          <li><a href="<?= $v->url('/audio') ?>">Audio & HiFi</a></li>
        </ul>
      </div>

      <div>
        <h4 class="footer-heading">Customer Service</h4>
        <ul class="footer-links">
          <li><a href="<?= $v->url('/contact') ?>">Contact Us</a></li>
          <li><a href="<?= $v->url('/shipping') ?>">Shipping & Delivery</a></li>
          <li><a href="<?= $v->url('/returns') ?>">Returns Policy</a></li>
          <li><a href="<?= $v->url('/faq') ?>">FAQ</a></li>
        </ul>
      </div>

      <div>
        <h4 class="footer-heading">Legal</h4>
        <ul class="footer-links">
          <li><a href="<?= $v->url('/terms') ?>">Terms of Service</a></li>
          <li><a href="<?= $v->url('/privacy') ?>">Privacy Policy</a></li>
          <li><a href="<?= $v->url('/cookies') ?>">Cookie Policy</a></li>
        </ul>
      </div>
    </div>

    <div class="footer-bottom">
      <span>&copy; <?= date('Y') ?> TechStore. All rights reserved.</span>
      <span>Branch: <strong><?= $v->e($branch['name'] ?? 'Main Branch') ?></strong></span>
    </div>
  </div>
</footer>

<!-- ═══ CART DRAWER (off-canvas) ════════════════════════════ -->
<?= $v->partial('cart-drawer') ?>

<!-- ═══ SCRIPTS ═════════════════════════════════════════════ -->
<script>
    window.App = {
        csrfToken:  '<?= $v->e($csrf_token) ?>',
        lang:       '<?= $v->e($lang->getCurrent()) ?>',
        branchId:   <?= (int) ($branch['id'] ?? 0) ?>,
        apiBaseUrl: '/api/v1',
        cartCount:  <?= (int) $cart_count ?>
    };
</script>
<script src="<?= $v->asset('js/app.js') ?>"></script>
<?= $v->yield('foot_scripts') ?>
</body>
</html>
