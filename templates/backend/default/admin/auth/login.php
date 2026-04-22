<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= $v->e($title ?? 'Admin Login') ?> — TechStore</title>
    <meta name="robots" content="noindex,nofollow">
    <link rel="stylesheet" href="<?= $v->asset('css/admin.css') ?>">
    <meta name="csrf-token" content="<?= $v->e($csrf_token) ?>">
    <style>
        body.login-page {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            background: var(--admin-bg, #f1f5f9);
        }
        .login-card {
            background: white;
            padding: 2.5rem;
            border-radius: var(--radius-lg, 12px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            width: 100%;
            max-width: 400px;
        }
        .login-logo {
            text-align: center;
            margin-bottom: 2rem;
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--color-primary, #3b82f6);
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--color-gray-700, #334155);
        }
        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid var(--color-gray-300, #cbd5e1);
            border-radius: var(--radius-md, 8px);
            font-size: 1rem;
        }
        .form-control:focus {
            outline: none;
            border-color: var(--color-primary, #3b82f6);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }
        .btn-block {
            width: 100%;
            padding: 0.75rem 1.5rem;
            background: var(--color-primary, #3b82f6);
            color: white;
            border: none;
            border-radius: var(--radius-md, 8px);
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .btn-block:hover {
            background: var(--color-primary-dark, #2563eb);
        }
        .alert {
            padding: 1rem;
            border-radius: var(--radius-md, 8px);
            margin-bottom: 1.5rem;
        }
        .alert-error {
            background: #fee2e2;
            color: #ef4444;
            border: 1px solid #f87171;
        }
        .alert-success {
            background: #d1fae5;
            color: #10b981;
            border: 1px solid #34d399;
        }
    </style>
</head>
<body class="login-page">

    <div class="login-card">
        <div class="login-logo">
            TechStore Admin
        </div>

        <?php if ($error = session_get_flash('error')): ?>
            <div class="alert alert-error"><?= $v->e($error) ?></div>
        <?php endif; ?>
        <?php if ($success = session_get_flash('success')): ?>
            <div class="alert alert-success"><?= $v->e($success) ?></div>
        <?php endif; ?>

        <form action="<?= $v->url('/admin/login') ?>" method="POST">
            <input type="hidden" name="csrf_token" value="<?= $v->e($csrf_token) ?>">

            <div class="form-group">
                <label for="email" class="form-label">E-Mail Adresse</label>
                <input type="email" id="email" name="email" class="form-control" required autofocus placeholder="admin@techstore.de">
            </div>

            <div class="form-group">
                <label for="password" class="form-label">Passwort</label>
                <input type="password" id="password" name="password" class="form-control" required placeholder="Admin1234!">
            </div>

            <button type="submit" class="btn-block">Anmelden</button>
        </form>
    </div>

</body>
</html>
