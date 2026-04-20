<?php $v->extend('main'); ?>

<section class="section-500" style="padding: 100px 20px; text-align: center; min-height: 60vh; display: flex; align-items: center; justify-content: center; flex-direction: column; background: var(--color-gray-50);">
    <div class="container">
        <h1 style="font-size: 6rem; font-weight: 900; color: var(--color-danger); line-height: 1; margin-bottom: 20px;">500</h1>
        <h2 style="font-size: 2rem; font-weight: 700; color: var(--color-gray-900); margin-bottom: 16px;">
            <?= $v->e($title ?? 'Interner Serverfehler') ?>
        </h2>
        <p style="font-size: 1.1rem; color: var(--color-gray-500); max-width: 500px; margin: 0 auto 32px;">
            Wir bitten um Entschuldigung. Unser Server hat derzeit ein Problem, diese Anfrage zu verarbeiten. Bitte versuchen Sie es in ein paar Minuten erneut.
        </p>
        <div style="display: flex; gap: 16px; justify-content: center;">
            <a href="<?= $v->url('/') ?>" class="btn btn--primary btn--lg">
                Zurück zur Startseite
            </a>
        </div>
    </div>
</section>
