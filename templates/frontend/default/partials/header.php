<header class="site-header" role="banner">
    <div class="container header-inner">

        <!-- Logo -->
        <a href="<?= $v->url('/') ?>" class="header-logo" aria-label="<?= $v->e(config('app.name')) ?>">
            <?php if (!empty($branch['logo'])): ?>
                <img src="<?= $v->asset($branch['logo']) ?>"
                     alt="<?= $v->e($branch['name']) ?>"
                     width="160" height="48" loading="eager">
            <?php else: ?>
                <span class="logo-text"><?= $v->e($branch['name'] ?? config('app.name')) ?></span>
            <?php endif; ?>
        </a>

        <!-- Main Navigation (desktop) -->
        <nav class="main-nav" aria-label="<?= $v->t('nav.main') ?>">
            <?php
            $menuItems = get_menu('header', $lang->getCurrent());
            foreach ($menuItems as $item):
            ?>
            <?php if (!empty($item['children'])): ?>
            <div class="nav-item has-dropdown">
                <a href="<?= $v->e($item['url']) ?>" class="nav-link">
                    <?= $v->e($item['label']) ?>
                    <svg class="icon-chevron" aria-hidden="true" width="12" height="12">
                        <use href="<?= $v->asset('icons/sprite.svg') ?>#chevron-down"></use>
                    </svg>
                </a>
                <ul class="dropdown-menu" role="menu">
                    <?php foreach ($item['children'] as $child): ?>
                    <li role="none">
                        <a href="<?= $v->e($child['url']) ?>" role="menuitem"><?= $v->e($child['label']) ?></a>
                    </li>
                    <?php endforeach; ?>
                </ul>
            </div>
            <?php else: ?>
            <a href="<?= $v->e($item['url']) ?>" class="nav-link"><?= $v->e($item['label']) ?></a>
            <?php endif; ?>
            <?php endforeach; ?>
        </nav>

        <!-- Header Actions -->
        <div class="header-actions">

            <!-- Search -->
            <button class="btn-icon" id="searchToggle"
                    aria-label="<?= $v->t('nav.search') ?>"
                    aria-expanded="false" aria-controls="searchBar">
                <svg width="20" height="20" aria-hidden="true">
                    <use href="<?= $v->asset('icons/sprite.svg') ?>#search"></use>
                </svg>
            </button>

            <!-- Language Switcher -->
            <div class="lang-switcher" aria-label="<?= $v->t('nav.language') ?>">
                <?php foreach (active_languages() as $langItem): ?>
                <a href="/<?= $v->e($langItem['code']) ?><?= $v->e(request_path()) ?>"
                   class="lang-option <?= $lang->getCurrent() === $langItem['code'] ? 'active' : '' ?>"
                   hreflang="<?= $v->e($langItem['code']) ?>"
                   lang="<?= $v->e($langItem['code']) ?>">
                    <span aria-hidden="true"><?= $v->e($langItem['flag']) ?></span>
                    <span class="sr-only"><?= $v->e($langItem['name']) ?></span>
                </a>
                <?php endforeach; ?>
            </div>

            <!-- My Account -->
            <?php if ($auth->check()): ?>
            <div class="account-menu">
                <button class="btn-icon" aria-label="<?= $v->t('nav.my_account') ?>">
                    <svg width="20" height="20" aria-hidden="true">
                        <use href="<?= $v->asset('icons/sprite.svg') ?>#user"></use>
                    </svg>
                    <span class="account-name"><?= $v->e($auth->customer()['first_name']) ?></span>
                </button>
                <ul class="dropdown-menu account-dropdown" role="menu">
                    <li><a href="<?= $v->url('/account/orders') ?>"><?= $v->t('account.orders') ?></a></li>
                    <li><a href="<?= $v->url('/account/profile') ?>"><?= $v->t('account.profile') ?></a></li>
                    <li><a href="<?= $v->url('/account/addresses') ?>"><?= $v->t('account.addresses') ?></a></li>
                    <?php if ($auth->customer()['type'] === 'company'): ?>
                    <li><a href="<?= $v->url('/account/documents') ?>"><?= $v->t('account.documents') ?></a></li>
                    <?php endif; ?>
                    <li class="divider"></li>
                    <li><a href="<?= $v->url('/auth/logout') ?>"><?= $v->t('auth.logout') ?></a></li>
                </ul>
            </div>
            <?php else: ?>
            <a href="<?= $v->url('/auth/login') ?>" class="btn-icon" aria-label="<?= $v->t('auth.login') ?>">
                <svg width="20" height="20" aria-hidden="true">
                    <use href="<?= $v->asset('icons/sprite.svg') ?>#user"></use>
                </svg>
            </a>
            <?php endif; ?>

            <!-- Cart -->
            <button class="btn-icon cart-btn"
                    id="cartToggle"
                    aria-label="<?= $v->t('cart.open') ?>"
                    aria-expanded="false">
                <svg width="22" height="22" aria-hidden="true">
                    <use href="<?= $v->asset('icons/sprite.svg') ?>#shopping-cart"></use>
                </svg>
                <span class="cart-badge"
                      id="cartCount"
                      aria-live="polite"
                      <?= $cart_count === 0 ? 'hidden' : '' ?>>
                    <?= (int) $cart_count ?>
                </span>
            </button>

            <!-- Mobile Hamburger -->
            <button class="btn-icon mobile-menu-btn"
                    aria-label="<?= $v->t('nav.open_menu') ?>"
                    aria-expanded="false"
                    aria-controls="mobileMenu">
                <svg width="24" height="24" aria-hidden="true">
                    <use href="<?= $v->asset('icons/sprite.svg') ?>#menu"></use>
                </svg>
            </button>
        </div>
    </div>

    <!-- Search Bar (collapsible) -->
    <div class="search-bar" id="searchBar" role="search" hidden>
        <div class="container">
            <form action="<?= $v->url('/search') ?>" method="get" class="search-form">
                <label class="sr-only" for="siteSearch"><?= $v->t('nav.search') ?></label>
                <input type="search"
                       id="siteSearch"
                       name="q"
                       placeholder="<?= $v->t('search.placeholder') ?>"
                       autocomplete="off"
                       aria-autocomplete="list"
                       aria-controls="searchSuggestions">
                <button type="submit" class="btn btn--primary">
                    <?= $v->t('search.go') ?>
                </button>
            </form>
            <div id="searchSuggestions" role="listbox" aria-label="<?= $v->t('search.suggestions') ?>"></div>
        </div>
    </div>

    <!-- Mobile Navigation Drawer -->
    <nav class="mobile-nav" id="mobileMenu" aria-label="Mobile" hidden>
        <ul class="mobile-nav-list">
            <?php foreach ($menuItems as $item): ?>
            <li class="mobile-nav-item">
                <a href="<?= $v->e($item['url']) ?>" class="mobile-nav-link">
                    <?= $v->e($item['label']) ?>
                </a>
                <?php if (!empty($item['children'])): ?>
                <ul class="mobile-nav-sub">
                    <?php foreach ($item['children'] as $child): ?>
                    <li><a href="<?= $v->e($child['url']) ?>"><?= $v->e($child['label']) ?></a></li>
                    <?php endforeach; ?>
                </ul>
                <?php endif; ?>
            </li>
            <?php endforeach; ?>
        </ul>
    </nav>
</header>
