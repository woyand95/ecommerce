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
<a class="skip-link" href="#main-content"><?= $v->t('layout.skip_to_content') ?></a>

<!-- ═══ HEADER ═══════════════════════════════════════════════ -->
<?= $v->partial('header', ['branch' => $branch]) ?>

<!-- ═══ FLASH MESSAGES ══════════════════════════════════════ -->
<?= $v->partial('flash-messages') ?>

<!-- ═══ MAIN CONTENT ════════════════════════════════════════ -->
<main id="main-content" class="main-content" role="main">
    <?= $content ?>
</main>

<!-- ═══ FOOTER ══════════════════════════════════════════════ -->
<?= $v->partial('footer', ['branch' => $branch]) ?>

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
