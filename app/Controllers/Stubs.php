<?php
// Deprecated - Full implementations now exist in separate files.
// This file is kept for backward compatibility only.

namespace App\Controllers;
use App\Core\Controller;

class PageController extends Controller {
  public function show(array $p = []): void {
    $slug = $p['slug'] ?? '';
    $page = $this->db->fetchOne("
        SELECT p.*, COALESCE(pt.title, p.title) as title, COALESCE(pt.content, p.content) as content
        FROM pages p
        LEFT JOIN page_translations pt ON pt.page_id = p.id AND pt.lang_code = ?
        WHERE p.slug = ? AND p.is_active = 1
    ", [$this->lang(), $slug]);
    
    if (!$page) {
        $this->abort(404, 'Seite nicht gefunden');
        return;
    }
    
    $this->view('pages/show', ['title' => $page['title'], 'page' => $page]);
  }
}

class ErrorController extends Controller {
  public function notFound(array $p = []): void {
    http_response_code(404);
    $this->view('errors/404', ['title' => '404 - Seite nicht gefunden']);
  }
  
  public function serverError(array $p = []): void {
    http_response_code(500);
    $this->view('errors/500', ['title' => '500 - Serverfehler']);
  }
}
