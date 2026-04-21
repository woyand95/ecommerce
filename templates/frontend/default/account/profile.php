<?php clone $v; $v->extend('main'); ?>
<?php $v->section('account_content'); ?>

<div style="margin-bottom: 32px;">
    <h1 style="font-size: 1.75rem; font-weight: 800; color: var(--color-gray-900);">Mein Profil</h1>
    <p style="color: var(--color-gray-500); margin-top: 8px;">Verwalten Sie Ihre persönlichen Informationen und Kontoeinstellungen.</p>
</div>

<?php if (isset($success)): ?>
    <div style="background: var(--color-success-light); color: var(--color-success); padding: 16px; border-radius: var(--radius-md); margin-bottom: 24px; font-weight: 500;">
        <?= $v->e($success) ?>
    </div>
<?php endif; ?>
<?php if (isset($error)): ?>
    <div style="background: var(--color-danger-light); color: var(--color-danger); padding: 16px; border-radius: var(--radius-md); margin-bottom: 24px; font-weight: 500;">
        <?= $v->e($error) ?>
    </div>
<?php endif; ?>

<div style="background: white; border: 1px solid var(--color-gray-200); border-radius: var(--radius-lg); padding: 32px;">
    <form action="<?= $v->url('/account/profile') ?>" method="POST" style="display: grid; gap: 24px;">
        <input type="hidden" name="csrf_token" value="<?= csrf_token() ?>">

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px;">
            <div>
                <label style="display: block; font-size: 14px; font-weight: 600; color: var(--color-gray-700); margin-bottom: 8px;">Vorname</label>
                <input type="text" name="first_name" value="<?= $v->e($customer['first_name'] ?? '') ?>" required style="width: 100%; padding: 12px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-family: inherit; font-size: 15px; color: var(--color-gray-900); transition: border-color 0.2s; outline: none;" onfocus="this.style.borderColor='var(--color-primary)'" onblur="this.style.borderColor='var(--color-gray-300)'">
            </div>
            <div>
                <label style="display: block; font-size: 14px; font-weight: 600; color: var(--color-gray-700); margin-bottom: 8px;">Nachname</label>
                <input type="text" name="last_name" value="<?= $v->e($customer['last_name'] ?? '') ?>" required style="width: 100%; padding: 12px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-family: inherit; font-size: 15px; color: var(--color-gray-900); transition: border-color 0.2s; outline: none;" onfocus="this.style.borderColor='var(--color-primary)'" onblur="this.style.borderColor='var(--color-gray-300)'">
            </div>
        </div>

        <div>
            <label style="display: block; font-size: 14px; font-weight: 600; color: var(--color-gray-700); margin-bottom: 8px;">E-Mail-Adresse</label>
            <input type="email" name="email" value="<?= $v->e($customer['email']) ?>" required style="width: 100%; padding: 12px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-family: inherit; font-size: 15px; color: var(--color-gray-900); transition: border-color 0.2s; outline: none;" onfocus="this.style.borderColor='var(--color-primary)'" onblur="this.style.borderColor='var(--color-gray-300)'">
        </div>

        <div>
            <label style="display: block; font-size: 14px; font-weight: 600; color: var(--color-gray-700); margin-bottom: 8px;">Telefonnummer (optional)</label>
            <input type="tel" name="phone" value="<?= $v->e($customer['phone'] ?? '') ?>" style="width: 100%; padding: 12px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-family: inherit; font-size: 15px; color: var(--color-gray-900); transition: border-color 0.2s; outline: none;" onfocus="this.style.borderColor='var(--color-primary)'" onblur="this.style.borderColor='var(--color-gray-300)'">
        </div>

        <div style="border-top: 1px solid var(--color-gray-200); padding-top: 24px; margin-top: 8px;">
            <h2 style="font-size: 1.1rem; font-weight: 700; margin-bottom: 16px; color: var(--color-gray-800);">Passwort ändern</h2>
            <p style="color: var(--color-gray-500); font-size: 14px; margin-bottom: 24px;">Lassen Sie diese Felder leer, wenn Sie Ihr Passwort nicht ändern möchten.</p>

            <div style="display: grid; gap: 24px;">
                <div>
                    <label style="display: block; font-size: 14px; font-weight: 600; color: var(--color-gray-700); margin-bottom: 8px;">Neues Passwort</label>
                    <input type="password" name="new_password" style="width: 100%; padding: 12px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-family: inherit; font-size: 15px; color: var(--color-gray-900); transition: border-color 0.2s; outline: none;" onfocus="this.style.borderColor='var(--color-primary)'" onblur="this.style.borderColor='var(--color-gray-300)'">
                </div>
                <div>
                    <label style="display: block; font-size: 14px; font-weight: 600; color: var(--color-gray-700); margin-bottom: 8px;">Neues Passwort bestätigen</label>
                    <input type="password" name="password_confirmation" style="width: 100%; padding: 12px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-family: inherit; font-size: 15px; color: var(--color-gray-900); transition: border-color 0.2s; outline: none;" onfocus="this.style.borderColor='var(--color-primary)'" onblur="this.style.borderColor='var(--color-gray-300)'">
                </div>
            </div>
        </div>

        <div style="display: flex; justify-content: flex-end; margin-top: 16px;">
            <button type="submit" style="background: var(--color-primary); color: white; border: none; padding: 14px 32px; border-radius: var(--radius-md); font-weight: 600; font-size: 15px; cursor: pointer; transition: background 0.2s; outline: none;" onmouseover="this.style.background='var(--color-primary-dark)'" onmouseout="this.style.background='var(--color-primary)'">
                Speichern
            </button>
        </div>
    </form>
</div>

<?php $v->endSection(); ?>
<?php require __DIR__ . '/layout.php'; ?>
