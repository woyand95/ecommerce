<?php $v->extend('main'); ?>

<section class="section-404" style="padding: 100px 20px; text-align: center; min-height: 60vh; display: flex; align-items: center; justify-content: center; flex-direction: column;">
    <div class="container">
        <h1 style="font-size: 6rem; font-weight: 900; color: var(--color-primary); line-height: 1; margin-bottom: 20px;">404</h1>
        <h2 style="font-size: 2rem; font-weight: 700; color: var(--color-gray-900); margin-bottom: 16px;">
            <?= $v->e($title ?? 'Seite nicht gefunden') ?>
        </h2>
        <p style="font-size: 1.1rem; color: var(--color-gray-500); max-width: 500px; margin: 0 auto 32px;">
            Die von Ihnen gesuchte Seite existiert leider nicht. Möglicherweise wurde sie verschoben oder die Adresse ist fehlerhaft.
        </p>
        <div style="display: flex; gap: 16px; justify-content: center;">
            <a href="<?= $v->url('/') ?>" class="btn btn--primary btn--lg">
                Zur Startseite
            </a>
            <a href="<?= $v->url('/products') ?>" class="btn btn--secondary btn--lg">
                Alle Produkte
            </a>
        </div>
    </div>
</section>
