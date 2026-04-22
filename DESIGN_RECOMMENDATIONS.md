# TechStore E-Commerce: UI/UX & Design Recommendations

## 1. General Typography & Readability
- **Font Stack:** The current application effectively uses the system UI stack (`'Inter', system-ui, -apple-system, sans-serif`). Ensure the font is loading properly; if `Inter` is not loaded locally or via Google Fonts, it falls back to standard system fonts, which is great for performance, but importing variable fonts could provide a more distinct brand identity.
- **Hierarchy:** The contrast between `h1`, `h2`, and `p` tags is generally strong (`font-weight: 800` vs `400`). However, body copy (`.product-description-content`) could benefit from a slightly increased line-height (`1.6` is good, consider `1.7` for long descriptions).
- **Colors:** The current color palette relies on standard Tailwind-like scales (`--color-gray-900`, `--color-primary`). These are safe and accessible. However, ensuring text-to-background contrast on `btn--accent` (warning yellow background with gray-800 text) passes WCAG AA standards is critical.

## 2. Layout & Spacing (Grid/Flexbox)
- **Container Max-Widths:** The `.container` currently relies on `--container-max`. The layout is effectively wrapping to grids.
- **Product Cards:** The implementation using `grid-template-columns: repeat(auto-fit, minmax(120px, 1fr))` on categories and `repeat(4, 1fr)` on products is highly scalable.
- **Product Detail Grid:** The updated `product-detail.php` template uses a responsive CSS Grid (`1fr` on mobile turning into `1fr 400px` on desktop) which keeps the "Add to Cart" sticky and the gallery large. This is an optimal e-commerce pattern.

## 3. Mobile UX & Touch Targets
- **Interactive Elements:** Buttons (`.btn`) have adequate padding (`var(--space-3) var(--space-5)`). For mobile interfaces, minimum touch target sizes should be 44x44px. Buttons like `.btn-icon` and `.gallery-thumb` (80x80px) easily meet this.
- **Hover States on Touch Devices:** In `app.css`, product cards feature hover states (`transform: translateY(-2px)`, `box-shadow` changes) and reveal "Add to Cart" buttons. On mobile (touch screens), `:hover` states can get "stuck". We recommend wrapping hover interactions inside a media query: `@media (hover: hover) and (pointer: fine) { ... }` so mobile users don't have to click twice or deal with ghost hovers.
- **Mobile Navigation:** The `.admin-sidebar` uses a `transform: translateX(-100%)` toggle for mobile which is the correct pattern. Ensure the overlay background has a click-to-dismiss handler.

## 4. Interactive States & Micro-interactions
- **Add to Cart Drawer:** The system uses an off-canvas `.cart-drawer` which is excellent for keeping the user engaged on the shopping page without a hard redirect to the cart.
- **Loading States:** When submitting forms or clicking "Add to Cart", buttons should visually indicate processing (e.g., swapping the icon with a spinner, dropping opacity).
- **Focus Rings:** `*:focus-visible` should have an explicit outline (e.g., `outline: 2px solid var(--color-primary); outline-offset: 2px;`). This drastically improves accessibility for keyboard navigation.

## 5. Admin Dashboard UX
- **Data Tables:** `.table-responsive` allows horizontal scrolling. To improve UX on mobile, consider CSS grid-based tables or collapsing non-essential columns on narrow screens (`@media (max-width: 640px) { .hide-mobile { display: none; } }`).
- **Metric Cards:** The implemented cards (`.metric-card`) in `dashboard.php` use distinct background/icon colors representing success, warnings, and primary stats, providing a quick visual hierarchy for the store manager.
- **Context Switching:** The branch selector (`.branch-selector-wrap`) at the top of the sidebar is perfectly positioned, as branch scoping is the core architectural rule of the platform.
