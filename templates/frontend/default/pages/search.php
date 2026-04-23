<?php $v->extend('main'); ?>

<div class="container" style="padding: 4rem 0;">
    <h1 style="font-size: 2rem; margin-bottom: 1rem; color: var(--color-gray-900);">Suchergebnisse</h1>
    <div class="empty-state" style="padding: 3rem; background: var(--color-gray-50); border: 1px solid var(--color-gray-200); border-radius: var(--radius-md); text-align: center;">
        <p style="color: var(--color-gray-600); font-size: 1.1rem;">Die Suchfunktion wird derzeit überarbeitet.</p>
        <a href="<?= $v->url('/products') ?>" class="btn btn--primary mt-4" style="display: inline-block;">Alle Produkte anzeigen</a>
    </div>
</div>
