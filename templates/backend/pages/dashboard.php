<?php $v->extend('admin'); ?>

<?php $v->section('content'); ?>
<div class="dashboard-header">
    <div class="dashboard-title">
        <h1>Dashboard</h1>
        <p>Willkommen zurück, <?= $v->e($auth->adminUser()['name'] ?? 'Admin') ?>.</p>
    </div>
    <div class="dashboard-actions">
        <a href="<?= $v->url('/admin/orders') ?>" class="btn btn-primary">Bestellungen ansehen</a>
    </div>
</div>

<div class="dashboard-metrics">
    <!-- Umsatz -->
    <div class="metric-card">
        <div class="metric-card-icon" style="color: var(--color-success); background: var(--color-success-light);">
            <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M12 2v20M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/>
            </svg>
        </div>
        <div class="metric-card-info">
            <h3 class="metric-title">Umsatz Heute</h3>
            <p class="metric-value"><?= format_money($metrics['revenue_today'] ?? 0) ?></p>
        </div>
    </div>

    <!-- Bestellungen -->
    <div class="metric-card">
        <div class="metric-card-icon" style="color: var(--color-primary); background: var(--color-primary-light);">
            <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path>
                <polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline>
                <line x1="12" y1="22.08" x2="12" y2="12"></line>
            </svg>
        </div>
        <div class="metric-card-info">
            <h3 class="metric-title">Neue Bestellungen</h3>
            <p class="metric-value"><?= number_format($metrics['orders_today'] ?? 0) ?></p>
        </div>
    </div>

    <!-- Kunden -->
    <div class="metric-card">
        <div class="metric-card-icon" style="color: var(--color-warning); background: var(--color-warning-light);">
            <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                <circle cx="9" cy="7" r="4"></circle>
                <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
            </svg>
        </div>
        <div class="metric-card-info">
            <h3 class="metric-title">Aktive Kunden</h3>
            <p class="metric-value"><?= number_format($metrics['customers_total'] ?? 0) ?></p>
        </div>
    </div>
</div>

<div class="dashboard-grid">
    <!-- Recent Orders -->
    <div class="card card-table">
        <div class="card-header">
            <h2 class="card-title">Letzte Bestellungen</h2>
            <a href="<?= $v->url('/admin/orders') ?>" class="btn btn-sm btn-ghost">Alle ansehen</a>
        </div>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Bestellnummer</th>
                        <th>Kunde</th>
                        <th>Status</th>
                        <th class="text-right">Betrag</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if(empty($recent_orders)): ?>
                    <tr><td colspan="4" class="text-center text-muted">Keine neuen Bestellungen.</td></tr>
                    <?php else: ?>
                        <?php foreach($recent_orders as $order): ?>
                        <tr>
                            <td><a href="<?= $v->url('/admin/orders/' . $order['id']) ?>" class="link-primary"><?= $v->e($order['order_number']) ?></a></td>
                            <td><?= $v->e($order['customer_name'] ?? 'Gast') ?></td>
                            <td><span class="badge badge-<?= strtolower($order['status']) ?>"><?= $v->e($order['status']) ?></span></td>
                            <td class="text-right font-medium"><?= format_money($order['total_amount']) ?></td>
                        </tr>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Out of stock warnings -->
    <div class="card card-table">
        <div class="card-header">
            <h2 class="card-title">Bestandswarnungen</h2>
        </div>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Produkt</th>
                        <th>SKU</th>
                        <th class="text-right">Bestand</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if(empty($low_stock_products)): ?>
                    <tr><td colspan="3" class="text-center text-muted">Keine Bestandswarnungen.</td></tr>
                    <?php else: ?>
                        <?php foreach($low_stock_products as $product): ?>
                        <tr>
                            <td><a href="<?= $v->url('/admin/products/' . $product['id'] . '/edit') ?>" class="link-primary"><?= $v->e($product['name']) ?></a></td>
                            <td class="text-muted text-sm"><?= $v->e($product['sku']) ?></td>
                            <td class="text-right">
                                <span class="badge badge-danger"><?= (int)$product['stock'] ?></span>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>
</div>
<?php $v->endSection(); ?>
