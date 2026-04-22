<?php
// Layout wrapper for all account pages
$customer = $auth->customer();
?>
<section class="section-account" style="padding: 48px 0; background: var(--color-gray-50); min-height: 80vh;">
    <div class="container">

        <?php if ($error = session_get_flash('error')): ?>
            <div style="background:#fee2e2;color:#ef4444;padding:16px;border-radius:8px;margin-bottom:24px;border:1px solid #f87171;">
                <?= $v->e($error) ?>
            </div>
        <?php endif; ?>
        <?php if ($success = session_get_flash('success')): ?>
            <div style="background:#d1fae5;color:#10b981;padding:16px;border-radius:8px;margin-bottom:24px;border:1px solid #34d399;">
                <?= $v->e($success) ?>
            </div>
        <?php endif; ?>

        <div style="display: grid; grid-template-columns: 1fr; gap: 32px;">
            <style>
                @media (min-width: 1024px) {
                    .account-grid { grid-template-columns: 250px 1fr !important; }
                }
            </style>

            <div class="account-grid" style="display: grid; grid-template-columns: 1fr; gap: 32px; align-items: start;">

                <aside class="account-sidebar" style="background: white; border: 1px solid var(--color-gray-200); border-radius: var(--radius-lg); padding: 24px; position: sticky; top: 80px;">
                    <div style="margin-bottom: 24px; padding-bottom: 16px; border-bottom: 1px solid var(--color-gray-200);">
                        <div style="font-weight: 700; font-size: 1.1rem; color: var(--color-gray-900);">Hallo, <?= $v->e($customer['first_name'] ?? 'Kunde') ?></div>
                        <div style="font-size: 13px; color: var(--color-gray-500);"><?= $v->e($customer['email'] ?? '') ?></div>
                    </div>

                    <nav style="display: flex; flex-direction: column; gap: 8px;">
                        <?php
                        $path = request_path();
                        $links = [
                            '/account/orders' => 'Bestellungen',
                            '/account/profile' => 'Konto details',
                            '/account/addresses' => 'Adressen',
                            '/account/documents' => 'Dokumente'
                        ];
                        ?>

                        <?php foreach($links as $url => $label): ?>
                        <a href="<?= $v->url($url) ?>" style="display: block; padding: 12px 16px; border-radius: var(--radius-md); color: <?= strpos($path, $url) !== false ? 'var(--color-primary)' : 'var(--color-gray-700)' ?>; background: <?= strpos($path, $url) !== false ? 'var(--color-primary-light)' : 'transparent' ?>; font-weight: <?= strpos($path, $url) !== false ? '600' : '500' ?>; text-decoration: none; transition: all 0.2s;" onmouseover="this.style.background='<?= strpos($path, $url) !== false ? 'var(--color-primary-light)' : 'var(--color-gray-100)' ?>'" onmouseout="this.style.background='<?= strpos($path, $url) !== false ? 'var(--color-primary-light)' : 'transparent' ?>'">
                            <?= $label ?>
                        </a>
                        <?php endforeach; ?>

                        <a href="<?= $v->url('/auth/logout') ?>" style="display: block; padding: 12px 16px; margin-top: 16px; color: var(--color-danger); font-weight: 500; text-decoration: none; transition: all 0.2s;" onmouseover="this.style.background='var(--color-danger-light)'" onmouseout="this.style.background='transparent'">
                            Abmelden
                        </a>
                    </nav>
                </aside>

                <main class="account-content" style="background: white; border: 1px solid var(--color-gray-200); border-radius: var(--radius-lg); padding: 32px;">
                    <?= $v->yield('account_content') ?>
                </main>

            </div>
        </div>
    </div>
</section>
