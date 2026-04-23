# Template System Debugging & Refactoring Plan

## 1. Problem Diagnosis
The application frequently serves blank white pages ("White Screen of Death") on specific routes, while others render correctly. The system exhibits erratic behavior when attempting to resolve views for administrative endpoints, cart pages, and search/CMS pages.

## 2. Root Causes
- **Silent Failures in Output Buffers:** The custom `TemplateEngine` uses output buffering (`ob_start()`) combined with `include` to render PHP templates. In production (`APP_DEBUG=false`), `display_errors` is off. If a fatal error occurs inside an included template, the script halts immediately, the output buffer is discarded or trapped, and the global exception handler fails to intercept fatal compile/syntax errors, resulting in a blank page.
- **Missing View Files:** Controllers request views that physically do not exist in the `templates/` directory. For the frontend, these are: `cart/index`, `pages/search`, and `pages/show`. For the backend, almost all views are missing or in the wrong directory (`admin/categories/index`, etc.). When the `TemplateEngine` cannot find these files, it throws a `RuntimeException`.
- **Undefined Helper Functions:** The `admin.php` layout relies on an `admin_nav_item()` function that is not defined in `app/Helpers/functions.php`. Rendering the admin layout causes a fatal "Call to undefined function" error, immediately crashing the response.
- **Path Resolution Mismatches:** Controllers define paths like `admin/dashboard`, but the admin templates are actually located at `templates/backend/pages/dashboard.php`. The template engine's resolver (`resolvePath`) fails to map these accurately.

## 3. Debugging Steps
1. **Enable Error Exposure (Dev Mode):** Temporarily set `APP_DEBUG=true` in `.env`. This forces `error_reporting(E_ALL)` and `display_errors=1`, exposing the exact fatal errors and stack traces instead of a blank screen.
2. **Buffer Error Trapping:** Wrap the `include $filePath;` statement in `TemplateEngine::renderFile()` with a `try-catch (\Throwable $e)` block. Inside the catch, call `ob_get_clean()` to discard the broken partial rendering and throw a wrapped exception detailing the exact file that failed.
3. **Graceful Shutdown Handler:** Register a shutdown function in `bootstrap.php` using `register_shutdown_function()`. Check `error_get_last()` for fatal errors (`E_ERROR`, `E_PARSE`). If detected, flush buffers and output a standard 500 error page.

## 4. Architectural Issues
- **Tight Coupling:** Templates are tightly coupled to singletons (`\App\Core\Auth::getInstance()`) injected directly via `TemplateEngine`'s global variables.
- **Inconsistent Scopes:** There is no uniform enforcement of template mapping. Frontend controllers use `pages/products` while admin controllers mix `admin/categories/index` and `pages/cms/index`. The `TemplateEngine` assumes `$this->scope` sets the base directory (`frontend` vs `backend`), but the controllers feed it paths that break this structure.
- **Lack of Fallbacks:** There is no "view exists" check in the controller before rendering; it blindly passes to the engine, which halts the application if the view is missing.

## 5. Refactoring Plan
1. **Patch the Admin Layout:** Immediately define the missing `admin_nav_item()` function in `app/Helpers/functions.php` to restore the admin panel's basic functionality.
2. **Stub Missing Templates:** Generate baseline `.php` stubs for all missing files referenced by controllers (e.g., `cart/index.php`, `pages/search.php`, `admin/categories/index.php`) that simply extend the main layout and display a "Work in Progress" message.
3. **Unify View Paths:** Refactor all `$this->view()` calls in admin controllers to point accurately to `pages/...` or `auth/...` relative to the `templates/backend/default` scope, matching the physical directory structure.
4. **Harden TemplateEngine:** Implement the `try-catch` output buffer safety net described in the debugging steps to ensure future template errors result in logged exceptions rather than blank pages.

## 6. Example Template Structure (Code)

**Fixing the Undefined Helper (`app/Helpers/functions.php`):**
```php
if (!function_exists('admin_nav_item')) {
    function admin_nav_item(string $url, string $icon, string $label): string {
        $active = (str_starts_with($_SERVER['REQUEST_URI'], $url)) ? 'active' : '';
        return sprintf(
            '<a href="%s" class="nav-link %s"><svg class="icon"><use href="#%s"></use></svg>%s</a>',
            htmlspecialchars($url), $active, htmlspecialchars($icon), htmlspecialchars($label)
        );
    }
}
```

**Creating a Standardized Missing View Fallback (`templates/frontend/default/cart/index.php`):**
```php
<?php $v->extend('main'); ?>

<div class="container" style="padding: 4rem 0;">
    <h1><?= $v->e($title ?? 'Warenkorb') ?></h1>
    <div class="empty-state">
        <p>This view is under construction.</p>
    </div>
</div>
```

**Hardening the Template Engine (`app/Core/TemplateEngine.php`):**
```php
private function renderFile(string $filePath, ?array $vars = null): string
{
    if (!file_exists($filePath)) {
        throw new \RuntimeException("Template not found: $filePath");
    }

    extract($vars ?? $this->vars, EXTR_SKIP);
    $v = $this;

    ob_start();
    try {
        include $filePath;
        return ob_get_clean();
    } catch (\Throwable $e) {
        ob_end_clean();
        throw new \RuntimeException("Error rendering template {$filePath}: " . $e->getMessage(), 0, $e);
    }
}
```

## 7. Risk Analysis
- **Low Risk:** Adding missing functions and stub templates is safe and will immediately reduce 500 errors.
- **Medium Risk:** Refactoring the `TemplateEngine` buffer handling ensures errors are caught, but might expose previously hidden warnings if error reporting levels are changed globally.
- **High Risk:** Changing controller view paths (`$this->view('...')`) requires thorough manual regression testing across all admin and frontend routes to ensure paths map correctly to the file system.
