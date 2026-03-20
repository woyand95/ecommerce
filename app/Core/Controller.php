<?php

namespace App\Core;

class Controller {
    protected Request  $request;
    protected Response $response;
    protected Database $db;
    protected string   $scope;

    public function __construct(string $scope = 'frontend') {
        $this->scope    = $scope;
        $this->request  = new Request();
        $this->response = new Response();
        $this->db       = Database::getInstance();
    }

    protected function view(string $view, array $data = []): void {
        $engine = new TemplateEngine($this->scope);
        $engine->display($view, $data);
    }

    protected function json(mixed $data, int $status = 200): void {
        $this->response->json($data, $status);
    }

    protected function redirect(string $url): void {
        $this->response->redirect($url);
    }

    protected function flash(string $type, string $message): void {
        session_flash($type, $message);
    }

    protected function lang(): string {
        return $_SESSION['lang'] ?? 'de';
    }

    protected function customer(): ?array {
        return $_SESSION['customer'] ?? null;
    }

    protected function adminUser(): ?array {
        return $_SESSION['admin_user'] ?? null;
    }

    protected function adminBranchId(): ?int {
        return $this->adminUser()['branch_id'] ?? null;
    }

    protected function abort(int $code, string $message = ''): void {
        http_response_code($code);
        echo "<h1>$code</h1><p>" . htmlspecialchars($message) . "</p>";
        exit;
    }

    protected function validate(array $data, array $rules): array {
        // Minimal stub — full implementation would use App\Core\Validator
        return $data;
    }

    protected function apiCustomer(): ?array {
        return $_SESSION['customer'] ?? null;
    }
}
