<?php

namespace App\Core;

/**
 * Response class - HTTP response wrapper
 */
class Response
{
    private array $headers = [];
    private string $content = '';
    private int $statusCode = 200;

    public function json(mixed $data, int $status = 200): void
    {
        http_response_code($status);
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        exit;
    }

    public function html(string $content, int $status = 200): void
    {
        http_response_code($status);
        header('Content-Type: text/html; charset=utf-8');
        echo $content;
        exit;
    }

    public function redirect(string $url, int $status = 302): void
    {
        http_response_code($status);
        header("Location: $url");
        exit;
    }

    public function download(string $file, string $name = null): void
    {
        if (!file_exists($file)) {
            $this->notFound();
            return;
        }

        $name = $name ?? basename($file);
        header('Content-Type: application/octet-stream');
        header('Content-Disposition: attachment; filename="' . $name . '"');
        header('Content-Length: ' . filesize($file));
        readfile($file);
        exit;
    }

    public function setStatusCode(int $code): self
    {
        $this->statusCode = $code;
        http_response_code($code);
        return $this;
    }

    public function header(string $name, string $value): self
    {
        $this->headers[$name] = $value;
        header("$name: $value");
        return $this;
    }

    public function notFound(): void
    {
        http_response_code(404);
        $this->view('errors/404', [], 'layouts/error');
        exit;
    }

    public function forbidden(): void
    {
        http_response_code(403);
        $this->view('errors/403', [], 'layouts/error');
        exit;
    }

    public function unauthorized(): void
    {
        http_response_code(401);
        $this->view('errors/401', [], 'layouts/error');
        exit;
    }

    public function internalError(\Throwable $e): void
    {
        http_response_code(500);
        if (defined('APP_DEBUG') && APP_DEBUG) {
            echo '<pre style="background:#f5f5f5;padding:20px;overflow:auto;">';
            echo '<h2>' . htmlspecialchars($e->getMessage()) . '</h2>';
            echo '<p><strong>File:</strong> ' . htmlspecialchars($e->getFile()) . ':' . $e->getLine() . '</p>';
            echo '<h3>Stack Trace:</h3>';
            echo htmlspecialchars($e->getTraceAsString());
            echo '</pre>';
        } else {
            $this->view('errors/500', ['error' => $e], 'layouts/error');
        }
        exit;
    }

    public function view(string $template, array $data = [], ?string $layout = null): void
    {
        $engine = new TemplateEngine();
        $content = $engine->render($template, $data);
        
        if ($layout) {
            $content = $engine->render($layout, ['content' => $content] + $data);
        }
        
        echo $content;
    }

    public function success(string $message, mixed $data = null): void
    {
        $this->json([
            'success' => true,
            'message' => $message,
            'data' => $data
        ]);
    }

    public function error(string $message, int $status = 400, mixed $errors = null): void
    {
        $this->json([
            'success' => false,
            'message' => $message,
            'errors' => $errors
        ], $status);
    }
}
