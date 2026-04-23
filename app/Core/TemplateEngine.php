<?php

namespace App\Core;

/**
 * TemplateEngine — Twig-inspired PHP template system.
 *
 * Features:
 *  - Layout-based rendering (header/footer/content)
 *  - Partial includes with data passing
 *  - Per-branch theme override support
 *  - XSS escaping by default
 *  - Section/yield blocks
 *  - Asset versioning
 */
class TemplateEngine
{
    private string  $viewsPath;
    private string  $themeName;
    private string  $scope;               // 'frontend' | 'backend'
    private array   $globals  = [];
    private array   $sections = [];
    private ?string $layout   = null;
    private array   $vars     = [];

    public function __construct(string $scope = 'frontend', string $themeName = 'default')
    {
        $this->scope     = $scope;
        $this->themeName = $themeName;
        $this->viewsPath = TEMPLATES_PATH . "/$scope";

        // Always-available globals
        $this->globals = [
            'app_name'   => config('app.name'),
            'lang'       => \App\Core\Lang::getInstance(),
            'auth'       => \App\Core\Auth::getInstance(),
            'branch'     => \App\Services\BranchService::getCurrent(),
            'cart_count' => \App\Services\CartService::count(),
            'csrf_token' => \App\Core\Csrf::token(),
        ];
    }

    // ── Public API ───────────────────────────────────────────

    /**
     * Render a view with optional data and an enclosing layout.
     *
     * @param string $view  e.g. 'pages/product-detail'
     * @param array  $data  Variables to expose inside the template
     */
    public function render(string $view, array $data = []): string
    {
        $this->vars    = array_merge($this->globals, $data);
        $this->layout  = null;
        $this->sections = [];

        // Render the view content first (it may call $this->extend())
        $content = $this->renderFile($this->resolvePath($view));

        // If view declared a layout, wrap it
        if ($this->layout !== null) {
            $this->vars['content'] = $content;
            return $this->renderFile($this->resolvePath($this->layout, 'layouts'));
        }

        return $content;
    }

    /** Output directly (calls render + echo). */
    public function display(string $view, array $data = []): void
    {
        echo $this->render($view, $data);
    }

    // ── Inside-template helpers (called from .php template files) ──

    /** Declare which layout wraps this view. */
    public function extend(string $layoutName): void
    {
        $this->layout = $layoutName;
    }

    /** Start capturing a named section. */
    public function section(string $name): void
    {
        $this->sections[$name] = null;
        ob_start();
    }

    /** End a named section. */
    public function endSection(): void
    {
        $name = array_key_last($this->sections);
        $this->sections[$name] = ob_get_clean();
    }

    /** Output a section's content (used in layouts). */
    public function yield(string $name, string $default = ''): string
    {
        return $this->sections[$name] ?? $default;
    }

    /**
     * Include a reusable partial.
     *
     * @param string $partial  e.g. 'cards/product-card'
     * @param array  $data     Extra variables scoped to this partial
     */
    public function partial(string $partial, array $data = []): string
    {
        $mergedVars = array_merge($this->vars, $data);
        return $this->renderFile($this->resolvePath($partial, 'partials'), $mergedVars);
    }

    /** HTML-escape a value. Always use this for user content. */
    public function e(mixed $value): string
    {
        return htmlspecialchars((string) $value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
    }

    /** Output a versioned asset URL. */
    public function asset(string $path): string
    {
        $full   = PUBLIC_PATH . '/assets/' . ltrim($path, '/');
        $ver    = file_exists($full) ? '?v=' . substr(md5_file($full), 0, 8) : '';
        $branch = $this->globals['branch']['slug'] ?? '';

        // Per-branch theme asset override
        $themePath = "/assets/themes/{$this->themeName}/{$branch}/$path";
        if (file_exists(PUBLIC_PATH . $themePath)) {
            return $themePath . $ver;
        }
        return '/assets/' . ltrim($path, '/') . $ver;
    }

    /** Generate a language-prefixed URL. */
    public function url(string $path = '', array $params = []): string
    {
        $lang   = $this->globals['lang']->getCurrent();
        $base   = '/' . $lang . '/' . ltrim($path, '/');
        $query  = $params ? '?' . http_build_query($params) : '';
        return rtrim($base, '/') . $query;
    }

    /** Translate a key. */
    public function t(string $key, array $replace = []): string
    {
        return $this->globals['lang']->get($key, $replace);
    }

    // ── Private ──────────────────────────────────────────────

    private function renderFile(string $filePath, ?array $vars = null): string
    {
        if (!file_exists($filePath)) {
            throw new \RuntimeException("Template not found: $filePath");
        }

        // Expose variables and helpers to template scope
        extract($vars ?? $this->vars, EXTR_SKIP);
        $v   = $this;   // Template engine instance available as $v inside templates

        ob_start();
        try {
            include $filePath;
            return ob_get_clean();
        } catch (\Throwable $e) {
            ob_end_clean();
            throw new \RuntimeException("Error rendering template {$filePath}: " . $e->getMessage(), 0, $e);
        }
    }

    /**
     * Resolve a template path with theme override fallback.
     *
     * Priority: branch-override → theme → default
     */
    private function resolvePath(string $name, string $type = ''): string
    {
        $branch     = $this->globals['branch']['slug'] ?? '';
        $suffix     = str_replace('.', '/', $name) . '.php';
        $typePrefix = $type ? "$type/" : '';

        $candidates = [
            // 1. Branch-specific theme override
            "{$this->viewsPath}/{$this->themeName}/branches/{$branch}/{$typePrefix}{$suffix}",
            // 2. Active theme
            "{$this->viewsPath}/{$this->themeName}/{$typePrefix}{$suffix}",
            // 3. Default theme fallback
            "{$this->viewsPath}/default/{$typePrefix}{$suffix}",
        ];

        foreach ($candidates as $path) {
            if (file_exists($path)) return $path;
        }

        return $candidates[2]; // will throw a clean error in renderFile
    }
}
