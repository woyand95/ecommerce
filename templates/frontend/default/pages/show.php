<?php $v->extend('main'); ?>

<div class="container" style="padding: 4rem 0;">
    <h1 style="font-size: 2rem; margin-bottom: 1rem; color: var(--color-gray-900);"><?= $v->e($title ?? 'Seite') ?></h1>
    <div style="padding: 2rem; background: white; border: 1px solid var(--color-gray-200); border-radius: var(--radius-md);">
        <?php if (!empty($page['content'])): ?>
            <?= $page['content'] ?>
        <?php else: ?>
            <p style="color: var(--color-gray-600);">Inhalt konnte nicht geladen werden.</p>
        <?php endif; ?>
    </div>
</div>
