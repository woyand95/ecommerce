<?php $v->extend('main'); ?>

<section class="section-auth" style="padding: 64px 20px; background: var(--color-gray-50); min-height: 70vh; display: flex; align-items: center; justify-content: center;">
    <div style="background: white; border: 1px solid var(--color-gray-200); border-radius: var(--radius-xl); padding: 40px; width: 100%; max-width: 540px; box-shadow: var(--shadow-md);">

        <div style="text-align: center; margin-bottom: 32px;">
            <h1 style="font-size: 2rem; font-weight: 800; color: var(--color-gray-900); margin-bottom: 8px;">Registrieren</h1>
            <p style="color: var(--color-gray-500); font-size: 14px;">Erstellen Sie ein neues Kundenkonto.</p>
        </div>

        <?php if ($error = session_get_flash('error')): ?>
            <div style="background: #fee2e2; color: #ef4444; border: 1px solid #f87171; padding: 12px; border-radius: var(--radius-md); margin-bottom: 24px; font-size: 14px;">
                <?= $v->e($error) ?>
            </div>
        <?php endif; ?>

        <form action="<?= $v->url('/auth/register') ?>" method="POST" style="display: flex; flex-direction: column; gap: 20px;">
            <input type="hidden" name="csrf_token" value="<?= $v->e($csrf_token) ?>">

            <div style="display: flex; gap: 16px;">
                <div style="flex: 1; display: flex; flex-direction: column; gap: 8px;">
                    <label for="first_name" style="font-size: 14px; font-weight: 600; color: var(--color-gray-700);">Vorname</label>
                    <input type="text" id="first_name" name="first_name" value="<?= $v->e(old('first_name')) ?>" required autofocus
                           style="width: 100%; padding: 12px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-size: 16px; transition: border-color 0.2s;"
                           onfocus="this.style.borderColor='var(--color-primary)'; this.style.outline='none';" onblur="this.style.borderColor='var(--color-gray-300)';">
                </div>
                <div style="flex: 1; display: flex; flex-direction: column; gap: 8px;">
                    <label for="last_name" style="font-size: 14px; font-weight: 600; color: var(--color-gray-700);">Nachname</label>
                    <input type="text" id="last_name" name="last_name" value="<?= $v->e(old('last_name')) ?>" required
                           style="width: 100%; padding: 12px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-size: 16px; transition: border-color 0.2s;"
                           onfocus="this.style.borderColor='var(--color-primary)'; this.style.outline='none';" onblur="this.style.borderColor='var(--color-gray-300)';">
                </div>
            </div>

            <div style="display: flex; flex-direction: column; gap: 8px;">
                <label for="email" style="font-size: 14px; font-weight: 600; color: var(--color-gray-700);">E-Mail Adresse</label>
                <input type="email" id="email" name="email" value="<?= $v->e(old('email')) ?>" required
                       style="width: 100%; padding: 12px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-size: 16px; transition: border-color 0.2s;"
                       onfocus="this.style.borderColor='var(--color-primary)'; this.style.outline='none';" onblur="this.style.borderColor='var(--color-gray-300)';">
            </div>

            <div style="display: flex; flex-direction: column; gap: 8px;">
                <label for="branch_id" style="font-size: 14px; font-weight: 600; color: var(--color-gray-700);">Ihre bevorzugte Filiale</label>
                <select id="branch_id" name="branch_id" required
                        style="width: 100%; padding: 12px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-size: 16px; background-color: white; transition: border-color 0.2s;"
                        onfocus="this.style.borderColor='var(--color-primary)'; this.style.outline='none';" onblur="this.style.borderColor='var(--color-gray-300)';">
                    <option value="" disabled <?= !old('branch_id') ? 'selected' : '' ?>>Bitte wählen...</option>
                    <?php foreach($branches ?? [] as $b): ?>
                        <option value="<?= $v->e($b['id']) ?>" <?= old('branch_id') == $b['id'] ? 'selected' : '' ?>><?= $v->e($b['name']) ?></option>
                    <?php endforeach; ?>
                </select>
                <p style="font-size: 12px; color: var(--color-gray-500); margin: 0;">Filialpreise und Verfügbarkeiten richten sich nach dieser Auswahl.</p>
            </div>

            <div style="display: flex; flex-direction: column; gap: 8px;">
                <label for="password" style="font-size: 14px; font-weight: 600; color: var(--color-gray-700);">Passwort</label>
                <input type="password" id="password" name="password" required minlength="8"
                       style="width: 100%; padding: 12px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-size: 16px; transition: border-color 0.2s;"
                       onfocus="this.style.borderColor='var(--color-primary)'; this.style.outline='none';" onblur="this.style.borderColor='var(--color-gray-300)';">
            </div>

            <label style="display: flex; align-items: flex-start; gap: 12px; cursor: pointer; font-size: 14px; color: var(--color-gray-600); margin-top: 8px;">
                <input type="checkbox" name="terms" required style="width: 16px; height: 16px; border: 1px solid var(--color-gray-300); border-radius: 4px; margin-top: 2px;">
                <span>Ich habe die <a href="<?= $v->url('/agb') ?>" style="color: var(--color-primary);">AGB</a> und <a href="<?= $v->url('/datenschutz') ?>" style="color: var(--color-primary);">Datenschutzbestimmungen</a> gelesen und akzeptiert.</span>
            </label>

            <button type="submit" class="btn btn--primary btn--lg btn--full" style="margin-top: 16px;">
                Kostenlos registrieren
            </button>
        </form>

        <div style="margin-top: 32px; padding-top: 24px; border-top: 1px solid var(--color-gray-200); text-align: center; font-size: 14px; color: var(--color-gray-600);">
            Bereits ein Konto? <a href="<?= $v->url('/auth/login') ?>" style="color: var(--color-primary); font-weight: 600; text-decoration: none;">Hier anmelden</a>
        </div>
    </div>
</section>
