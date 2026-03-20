<?php
$messages = session_flash_get();
if (empty($messages)) return;
?>
<div class="flash-messages container" aria-live="polite">
    <?php foreach ($messages as $type => $texts):
        foreach ((array)$texts as $text): ?>
    <div class="flash flash--<?= $v->e($type) ?>" role="alert">
        <span class="flash-message"><?= $v->e($text) ?></span>
        <button class="flash-close" aria-label="Dismiss">
            <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2">
                <line x1="14" y1="0" x2="0" y2="14"/><line x1="0" y1="0" x2="14" y2="14"/>
            </svg>
        </button>
    </div>
    <?php endforeach; endforeach; ?>
</div>
