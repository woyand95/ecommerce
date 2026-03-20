<!DOCTYPE html>
<html lang="<?= $v->e($lang->getCurrent()) ?>">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= $v->e($title ?? 'Admin') ?> — <?= $v->e(config('app.name')) ?> Admin</title>
    <meta name="robots" content="noindex,nofollow">
    <link rel="stylesheet" href="<?= $v->asset('css/admin.css') ?>">
    <meta name="csrf-token" content="<?= $v->e($csrf_token) ?>">
    <?= $v->yield('head_styles') ?>
</head>
<body class="admin-layout" data-theme="light">

<!-- ═══ SIDEBAR ══════════════════════════════════════════════ -->
<aside class="admin-sidebar" id="adminSidebar" aria-label="Admin Navigation">
    <div class="sidebar-header">
        <a href="/admin" class="sidebar-logo">
            <svg class="logo-icon" width="32" height="32" aria-hidden="true">
                <use href="<?= $v->asset('icons/admin-sprite.svg') ?>#logo"></use>
            </svg>
            <span class="logo-text"><?= $v->e(config('app.name')) ?></span>
        </a>
        <button class="sidebar-collapse-btn" aria-label="Collapse Sidebar">
            <svg width="16" height="16" aria-hidden="true">
                <use href="<?= $v->asset('icons/admin-sprite.svg') ?>#panel-left"></use>
            </svg>
        </button>
    </div>

    <!-- Branch selector for superadmin -->
    <?php if (!$auth->adminUser()['branch_id']): ?>
    <div class="branch-selector-wrap">
        <label class="sr-only" for="branchSwitch">Branch</label>
        <select id="branchSwitch" class="branch-selector"
                data-action="switchBranch">
            <option value="">All Branches</option>
            <?php foreach ($branches as $b): ?>
            <option value="<?= $v->e($b['id']) ?>"
                    <?= ($current_branch_id ?? null) == $b['id'] ? 'selected' : '' ?>>
                <?= $v->e($b['name']) ?>
            </option>
            <?php endforeach; ?>
        </select>
    </div>
    <?php endif; ?>

    <nav class="sidebar-nav" role="navigation" aria-label="Admin Menu">
        <ul class="nav-group" role="list">
            <li class="nav-group-label">Dashboard</li>
            <li><?= admin_nav_item('/admin', 'dashboard', 'Dashboard') ?></li>
        </ul>

        <ul class="nav-group" role="list">
            <li class="nav-group-label"><?= $v->t('admin.nav.catalog') ?></li>
            <li><?= admin_nav_item('/admin/products',  'box',      'Products') ?></li>
            <li><?= admin_nav_item('/admin/categories','folder',   'Categories') ?></li>
            <li><?= admin_nav_item('/admin/attributes','sliders',  'Attributes') ?></li>
        </ul>

        <ul class="nav-group" role="list">
            <li class="nav-group-label"><?= $v->t('admin.nav.sales') ?></li>
            <li><?= admin_nav_item('/admin/orders',    'shopping-bag', 'Orders') ?></li>
            <li><?= admin_nav_item('/admin/campaigns', 'tag',          'Campaigns') ?></li>
        </ul>

        <ul class="nav-group" role="list">
            <li class="nav-group-label"><?= $v->t('admin.nav.customers') ?></li>
            <li><?= admin_nav_item('/admin/customers',  'users',     'Customers') ?></li>
            <li><?= admin_nav_item('/admin/documents',  'file-text', 'Documents') ?></li>
        </ul>

        <ul class="nav-group" role="list">
            <li class="nav-group-label"><?= $v->t('admin.nav.content') ?></li>
            <li><?= admin_nav_item('/admin/pages',  'layout',  'Pages / CMS') ?></li>
            <li><?= admin_nav_item('/admin/menus',  'menu',    'Menus') ?></li>
            <li><?= admin_nav_item('/admin/media',  'image',   'Media Library') ?></li>
        </ul>

        <?php if (!$auth->adminUser()['branch_id']): // Superadmin only ?>
        <ul class="nav-group" role="list">
            <li class="nav-group-label"><?= $v->t('admin.nav.system') ?></li>
            <li><?= admin_nav_item('/admin/branches',  'git-branch', 'Branches') ?></li>
            <li><?= admin_nav_item('/admin/languages', 'globe',      'Languages') ?></li>
            <li><?= admin_nav_item('/admin/users',     'shield',     'Admin Users') ?></li>
            <li><?= admin_nav_item('/admin/settings',  'settings',   'Settings') ?></li>
        </ul>
        <?php endif; ?>
    </nav>
</aside>

<!-- ═══ MAIN PANEL ═══════════════════════════════════════════ -->
<div class="admin-main" id="adminMain">

    <!-- Top Bar -->
    <header class="admin-topbar" role="banner">
        <button class="mobile-sidebar-toggle" aria-label="Open Menu"
                aria-expanded="false" aria-controls="adminSidebar">
            <svg width="20" height="20" aria-hidden="true">
                <use href="<?= $v->asset('icons/admin-sprite.svg') ?>#menu"></use>
            </svg>
        </button>

        <h1 class="admin-page-title"><?= $v->e($title ?? '') ?></h1>

        <div class="topbar-actions">
            <!-- Notifications -->
            <button class="btn-icon" aria-label="Notifications">
                <svg width="18" height="18" aria-hidden="true">
                    <use href="<?= $v->asset('icons/admin-sprite.svg') ?>#bell"></use>
                </svg>
                <?php if ($pending_docs_count ?? 0): ?>
                <span class="notification-badge"><?= (int) $pending_docs_count ?></span>
                <?php endif; ?>
            </button>

            <!-- Admin user menu -->
            <div class="admin-user-menu">
                <button class="admin-user-btn" aria-label="User menu">
                    <div class="user-avatar">
                        <?= strtoupper(substr($auth->adminUser()['first_name'], 0, 1)) ?>
                    </div>
                    <span class="user-name"><?= $v->e($auth->adminUser()['first_name']) ?></span>
                </button>
                <ul class="admin-dropdown" role="menu">
                    <li><a href="/admin/profile" role="menuitem">Profile</a></li>
                    <li class="divider"></li>
                    <li><a href="/admin/logout" role="menuitem">Sign out</a></li>
                </ul>
            </div>
        </div>
    </header>

    <!-- Flash Messages -->
    <?= $v->partial('flash-messages') ?>

    <!-- Page Content -->
    <main class="admin-content" id="adminContent" role="main">
        <?= $content ?>
    </main>

    <!-- Footer -->
    <footer class="admin-footer" role="contentinfo">
        <span><?= $v->e(config('app.name')) ?> v<?= APP_VERSION ?></span>
        <span>PHP <?= PHP_VERSION ?> | MySQL</span>
    </footer>
</div>

<!-- Scripts -->
<script>
    window.AdminApp = {
        csrfToken: '<?= $v->e($csrf_token) ?>',
        branchId:  <?= (int) ($current_branch_id ?? 0) ?>,
        apiBase:   '/api/v1'
    };
</script>
<script src="<?= $v->asset('js/admin.js') ?>"></script>
<?= $v->yield('foot_scripts') ?>
</body>
</html>
