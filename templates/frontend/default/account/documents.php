<?php clone $v; $v->extend('main'); ?>
<?php $v->section('account_content'); ?>

<div style="margin-bottom: 32px;">
    <h1 style="font-size: 1.75rem; font-weight: 800; color: var(--color-gray-900);">Meine Dokumente</h1>
    <p style="color: var(--color-gray-500); margin-top: 8px;">Laden Sie Ihre Rechnungen und Lieferscheine herunter.</p>
</div>

<div style="background: white; border: 1px solid var(--color-gray-200); border-radius: var(--radius-lg); padding: 24px; margin-bottom: 32px;">
    <h2 style="font-size: 1.25rem; font-weight: 700; color: var(--color-gray-800); margin-bottom: 16px;">Neues Dokument hochladen</h2>
    <form action="<?= $v->url('/account/documents') ?>" method="POST" enctype="multipart/form-data" style="display: flex; gap: 16px; align-items: flex-end;">
        <input type="hidden" name="csrf_token" value="<?= $v->e($csrf_token ?? '') ?>">
        <div style="flex-grow: 1;">
            <label style="display: block; font-size: 14px; font-weight: 600; color: var(--color-gray-700); margin-bottom: 8px;">Gewerbenachweis / Dokument auswählen</label>
            <input type="file" name="document" required accept=".pdf,.jpg,.jpeg,.png" style="display: block; width: 100%; padding: 10px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-family: inherit; font-size: 14px; color: var(--color-gray-700); background: var(--color-gray-50);">
            <div style="font-size: 12px; color: var(--color-gray-500); margin-top: 8px;">Erlaubte Formate: PDF, JPG, PNG (Max. 5MB)</div>
        </div>
        <button type="submit" style="background: var(--color-primary); color: white; border: none; padding: 12px 24px; border-radius: var(--radius-md); font-weight: 600; font-size: 14px; cursor: pointer; transition: background 0.2s;" onmouseover="this.style.background='var(--color-primary-dark)'" onmouseout="this.style.background='var(--color-primary)'">Hochladen</button>
    </form>
</div>

<div style="background: white; border: 1px solid var(--color-gray-200); border-radius: var(--radius-lg); overflow: hidden;">
    <?php if (empty($documents)): ?>
        <div style="text-align: center; padding: 64px 24px;">
            <div style="font-size: 48px; margin-bottom: 16px; opacity: 0.5;">📄</div>
            <h3 style="font-size: 1.25rem; font-weight: 600; color: var(--color-gray-900); margin-bottom: 8px;">Keine Dokumente vorhanden</h3>
            <p style="color: var(--color-gray-500);">Ihre Rechnungen werden hier erscheinen, sobald Ihre Bestellungen versandt wurden.</p>
        </div>
    <?php else: ?>
        <table style="width: 100%; border-collapse: collapse; text-align: left;">
            <thead style="background: var(--color-gray-50); border-bottom: 1px solid var(--color-gray-200);">
                <tr>
                    <th style="padding: 16px 24px; font-size: 13px; color: var(--color-gray-500); font-weight: 600; text-transform: uppercase; letter-spacing: 0.05em;">Dokument</th>
                    <th style="padding: 16px 24px; font-size: 13px; color: var(--color-gray-500); font-weight: 600; text-transform: uppercase; letter-spacing: 0.05em;">Datum</th>
                    <th style="padding: 16px 24px; font-size: 13px; color: var(--color-gray-500); font-weight: 600; text-transform: uppercase; letter-spacing: 0.05em;">Status</th>
                    <th style="padding: 16px 24px; font-size: 13px; color: var(--color-gray-500); font-weight: 600; text-transform: uppercase; letter-spacing: 0.05em; text-align: right;">Aktion</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($documents as $doc): ?>
                <tr style="border-bottom: 1px solid var(--color-gray-100); transition: background 0.2s;" onmouseover="this.style.background='var(--color-gray-50)'" onmouseout="this.style.background='transparent'">
                    <td style="padding: 16px 24px;">
                        <div style="display: flex; align-items: center; gap: 12px;">
                            <span style="font-size: 24px;">📄</span>
                            <div>
                                <div style="font-weight: 600; color: var(--color-gray-900);"><?= $v->e($doc['type'] === 'verification' ? 'Verifizierung' : 'Dokument') ?></div>
                                <div style="font-size: 13px; color: var(--color-gray-500);"><?= $v->e(htmlspecialchars($doc['original_filename'])) ?></div>
                            </div>
                        </div>
                    </td>
                    <td style="padding: 16px 24px; color: var(--color-gray-700);">
                        <?= date('d.m.Y', strtotime($doc['created_at'])) ?>
                    </td>
                    <td style="padding: 16px 24px;">
                        <span style="display: inline-block; padding: 4px 12px; border-radius: 9999px; font-size: 12px; font-weight: 700; text-transform: uppercase; background: <?= $doc['status'] === 'verified' ? 'var(--color-success-light)' : ($doc['status'] === 'rejected' ? 'var(--color-danger-light)' : 'var(--color-warning-light)') ?>; color: <?= $doc['status'] === 'verified' ? 'var(--color-success)' : ($doc['status'] === 'rejected' ? 'var(--color-danger)' : 'var(--color-warning)') ?>;">
                            <?= $v->e(ucfirst($doc['status'])) ?>
                        </span>
                    </td>
                    <td style="padding: 16px 24px; text-align: right;">
                        <a href="<?= $v->url('/account/documents/' . $doc['id'] . '/download') ?>" style="display: inline-block; padding: 8px 16px; border: 1px solid var(--color-gray-300); border-radius: var(--radius-md); font-weight: 600; color: var(--color-gray-700); text-decoration: none; font-size: 13px; transition: all 0.2s;" onmouseover="this.style.background='var(--color-gray-100)'; this.style.borderColor='var(--color-gray-400)'" onmouseout="this.style.background='transparent'; this.style.borderColor='var(--color-gray-300)'">Herunterladen</a>
                    </td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php endif; ?>
</div>

<?php $v->endSection(); ?>
<?php require __DIR__ . '/layout.php'; ?>
