<?php $v->extend('main'); ?>

<section class="section-auth" style="padding: 64px 20px; background: var(--color-gray-50); min-height: 70vh; display: flex; align-items: center; justify-content: center;">
    <div style="background: white; border: 1px solid var(--color-gray-200); border-radius: var(--radius-xl); padding: 40px; width: 100%; max-width: 480px; box-shadow: var(--shadow-md);">

        <div style="text-align: center; margin-bottom: 32px;">
            <h1 style="font-size: 2rem; font-weight: 800; color: var(--color-gray-900); margin-bottom: 8px;">Anmelden</h1>
            <p style="color: var(--color-gray-500); font-size: 14px;">Loggen Sie sich in Ihr Kundenkonto ein.</p>
        </div>

        <?php if ($error = session_get_flash('error')): ?>
            <div style="background: #fee2e2; color: #ef4444; border: 1px solid #f87171; padding: 12px; border-radius: var(--radius-md); margin-bottom: 24px; font-size: 14px;">
                <?= $v->e($error) ?>
            </div>
        <?php endif; ?>

        <?php if ($success = session_get_flash('success')): ?>
            <div style="background: #d1fae5; color: #10b981; border: 1px solid #34d399; padding: 12px; border-radius: var(--radius-md); margin-bottom: 24px; font-size: 14px;">
                <?= $v->e($success) ?>
            </div>
        <?php endif; ?>

        <form action="<?= $v->url('/auth/login') ?>" method="POST" style="display: flex; flex-direction: column; gap: 20px;">
            <input type="hidden" name="csrf_token" value="<?= $v->e($csrf_token) ?>">
            <input type="hidden" name="branch_id" value="<?= $v->e($branch['id'] ?? $_SESSION['branch_id'] ?? 1) ?>">

            <div style="display: flex; flex-direction: column; gap: 8px;">
                <label for="email" style="font-size: 14px; font-weight: 600; color: var(--color-gray-700);">E-Mail Adresse</label>
                <input type="email" id="email" name="email" value="<?= $v->e(old('email')) ?>" required autofocus
                       style="width: 100%; padding: 12px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-size: 16px; transition: border-color 0.2s;"
                       onfocus="this.style.borderColor='var(--color-primary)'; this.style.outline='none';"
                       onblur="this.style.borderColor='var(--color-gray-300)';">
            </div>

            <div style="display: flex; flex-direction: column; gap: 8px;">
                <div style="display: flex; justify-content: space-between; align-items: baseline;">
                    <label for="password" style="font-size: 14px; font-weight: 600; color: var(--color-gray-700);">Passwort</label>
                    <a href="#" style="font-size: 12px; color: var(--color-primary); text-decoration: none;">Passwort vergessen?</a>
                </div>
                <input type="password" id="password" name="password" required
                       style="width: 100%; padding: 12px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-size: 16px; transition: border-color 0.2s;"
                       onfocus="this.style.borderColor='var(--color-primary)'; this.style.outline='none';"
                       onblur="this.style.borderColor='var(--color-gray-300)';">
            </div>

            <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; font-size: 14px; color: var(--color-gray-600);">
                <input type="checkbox" name="remember" style="width: 16px; height: 16px; border: 1px solid var(--color-gray-300); border-radius: 4px;">
                Angemeldet bleiben
            </label>

            <button type="submit" class="btn btn--primary btn--lg btn--full" style="margin-top: 8px;">
                Anmelden
            </button>
        </form>

        <div style="margin-top: 32px; padding-top: 24px; border-top: 1px solid var(--color-gray-200); text-align: center; font-size: 14px; color: var(--color-gray-600);">
            Neu hier? <a href="<?= $v->url('/auth/register') ?>" style="color: var(--color-primary); font-weight: 600; text-decoration: none;">Konto erstellen</a>
        </div>
    </div>
</section>
