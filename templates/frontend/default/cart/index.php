<?php $v->extend('main'); ?>

<div class="container" style="padding: 4rem 0;">
    <h1 style="font-size: 2rem; margin-bottom: 1rem; color: var(--color-gray-900);"><?= $v->e($title ?? 'Warenkorb') ?></h1>
    <div class="empty-state" style="padding: 3rem; background: var(--color-gray-50); border: 1px solid var(--color-gray-200); border-radius: var(--radius-md); text-align: center;">
        <svg width="48" height="48" aria-hidden="true" style="color: var(--color-gray-400); margin-bottom: 1rem;">
            <use href="<?= $v->asset('icons/sprite.svg') ?>#shopping-cart"></use>
        </svg>
        <p style="color: var(--color-gray-600); font-size: 1.1rem;">Dein Warenkorb ist derzeit leer oder wird geladen.</p>
        <a href="<?= $v->url('/products') ?>" class="btn btn--primary mt-4" style="display: inline-block;">Weiter einkaufen</a>
    </div>
</div>
