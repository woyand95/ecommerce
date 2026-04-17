<?php

namespace App\Core;

/**
 * Lang class - Translation/Language management
 */
class Lang
{
    private static ?self $instance = null;
    private array $translations = [];
    private string $current = 'de';
    private string $fallback = 'de';

    public static function getInstance(): self
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    public function getCurrent(): string
    {
        return $_SESSION['lang'] ?? $this->current;
    }

    public function setCurrent(string $lang): void
    {
        $this->current = $lang;
        $_SESSION['lang'] = $lang;
        $this->load($lang);
    }

    public function getFallback(): string
    {
        return $this->fallback;
    }

    public function setFallback(string $lang): void
    {
        $this->fallback = $lang;
    }

    public function get(string $key, array $replace = []): string
    {
        // Load translations if not already loaded
        if (empty($this->translations)) {
            $this->load($this->getCurrent());
        }

        // Get the translation or fallback to key
        $value = $this->translations[$key] ?? null;
        
        // Try fallback language if not found
        if ($value === null && $this->getCurrent() !== $this->fallback) {
            $fallbackTranslations = $this->loadFile($this->fallback);
            $value = $fallbackTranslations[$key] ?? $key;
        }
        
        if ($value === null) {
            $value = $key;
        }

        // Replace placeholders
        foreach ($replace as $k => $v) {
            $value = str_replace(':' . $k, (string) $v, $value);
        }

        return $value;
    }

    public function has(string $key): bool
    {
        if (empty($this->translations)) {
            $this->load($this->getCurrent());
        }
        return isset($this->translations[$key]);
    }

    private function load(string $lang): void
    {
        $this->translations = $this->loadFile($lang);
    }

    private function loadFile(string $lang): array
    {
        $file = ROOT_PATH . "/lang/{$lang}/general.php";
        if (file_exists($file)) {
            return require $file;
        }
        return [];
    }

    public function loadAdditional(string $file): void
    {
        $path = ROOT_PATH . "/lang/{$this->current}/{$file}.php";
        if (file_exists($path)) {
            $translations = require $path;
            $this->translations = array_merge($this->translations, $translations);
        }
    }

    public function all(): array
    {
        if (empty($this->translations)) {
            $this->load($this->getCurrent());
        }
        return $this->translations;
    }

    public function reset(): void
    {
        $this->translations = [];
    }
}
