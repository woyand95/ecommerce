<?php

namespace App\Middleware;

use App\Core\Request;
use App\Core\Response;
use App\Core\Auth;

/**
 * BranchMiddleware — The gatekeeper.
 *
 * Enforces the strict rule: customers can ONLY interact with their assigned branch.
 * Applied at:
 *  - Product listing (hides products not available for the customer's branch)
 *  - Cart operations
 *  - Checkout
 *  - Any order endpoint
 */
class BranchMiddleware
{
    public function __construct(
        private readonly Request  $request,
        private readonly Response $response
    ) {}

    public function handle(callable $next): void
    {
        $customer = Auth::customer();

        if (!$customer) {
            // Guest: detect branch from domain / subdomain
            $this->detectAndSetBranchForGuest();
            $next();
            return;
        }

        $customerBranchId  = (int) $customer['branch_id'];
        $requestedBranchId = $this->resolveBranchFromRequest();

        // If a branch is explicitly referenced in the request, it must match the customer's
        if ($requestedBranchId !== null && $requestedBranchId !== $customerBranchId) {
            $this->handleMismatch($customerBranchId, $requestedBranchId);
            return;
        }

        // Always override session branch with the customer's assigned branch
        $_SESSION['branch_id'] = $customerBranchId;

        $next();
    }

    // ── Detection helpers ─────────────────────────────────────

    private function detectAndSetBranchForGuest(): void
    {
        // Already set in session
        if (!empty($_SESSION['branch_id'])) return;

        $host   = $_SERVER['HTTP_HOST'] ?? '';
        $branch = \App\Models\Branch::findByDomain($host);

        if ($branch) {
            $_SESSION['branch_id']   = $branch['id'];
            $_SESSION['branch_slug'] = $branch['slug'];
        } else {
            // Fall back to default branch (id = 1)
            $_SESSION['branch_id'] = 1;
        }
    }

    /**
     * Extract branch_id from route params, body, or query string.
     */
    private function resolveBranchFromRequest(): ?int
    {
        // From route param  /branches/{branch_id}/...
        $routeParam = $this->request->param('branch_id');
        if ($routeParam) return (int) $routeParam;

        // From POST body (e.g. cart add)
        $bodyParam = $this->request->input('branch_id');
        if ($bodyParam) return (int) $bodyParam;

        return null;
    }

    private function handleMismatch(int $customerBranch, int $requestedBranch): void
    {
        if ($this->request->isApi()) {
            $this->response->json([
                'error' => 'branch_mismatch',
                'message' => 'You can only order from your assigned branch.',
                'your_branch_id' => $customerBranch,
            ], 403);
            return;
        }

        // Web: flash error and redirect to the customer's correct branch homepage
        session_flash('error', __('errors.branch_mismatch'));
        $this->response->redirect('/');
    }
}
