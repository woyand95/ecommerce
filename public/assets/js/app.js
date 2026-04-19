/**
 * app.js — Frontend JavaScript Bundle
 * Cart AJAX, search suggestions, nav, cart drawer, tabs, qty stepper
 */

'use strict';

/* ── Global config injected by layout ────────────────────── */
const App = window.App || {};

/* ── Utility helpers ─────────────────────────────────────── */
const $ = (sel, ctx = document) => ctx.querySelector(sel);
const $$ = (sel, ctx = document) => [...ctx.querySelectorAll(sel)];

async function apiFetch(url, opts = {}) {
  const res = await fetch(url, {
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-TOKEN': App.csrfToken,
      'Accept': 'application/json',
      ...opts.headers,
    },
    ...opts,
  });
  const data = await res.json();
  if (!res.ok) throw Object.assign(new Error(data.message || 'Request failed'), { data, status: res.status });
  return data;
}

function showToast(message, type = 'success') {
  const container = $('#toastContainer') || createToastContainer();
  const toast = document.createElement('div');
  toast.className = `toast toast--${type}`;
  toast.innerHTML = `
    <span class="toast-message">${message}</span>
    <button class="toast-close" aria-label="Close">✕</button>`;
  container.appendChild(toast);
  requestAnimationFrame(() => toast.classList.add('show'));
  const remove = () => { toast.classList.remove('show'); setTimeout(() => toast.remove(), 300); };
  toast.querySelector('.toast-close').addEventListener('click', remove);
  setTimeout(remove, 4000);
}

function createToastContainer() {
  const el = document.createElement('div');
  el.id = 'toastContainer';
  el.className = 'toast-container';
  el.setAttribute('aria-live', 'polite');
  document.body.appendChild(el);
  return el;
}

/* ── Cart ─────────────────────────────────────────────────── */
const Cart = (() => {

  function updateBadge(count) {
    const badge = $('#cartCount');
    if (!badge) return;
    badge.textContent = count;
    badge.hidden = count === 0;
    badge.animate([{ transform: 'scale(1.5)' }, { transform: 'scale(1)' }], { duration: 200 });
  }

  async function addItem(productId, variantId, quantity) {
    const btn = $('[data-product-id] .add-to-cart-btn') || $('.add-to-cart-btn');
    if (btn) { btn.disabled = true; btn.insertAdjacentHTML('afterbegin', '<span class="spinner"></span>'); }

    try {
      const data = await apiFetch('/api/v1/cart/add', {
        method: 'POST',
        body: JSON.stringify({ product_id: productId, variant_id: variantId, quantity }),
      });
      updateBadge(data.cart_count);
      CartDrawer.refresh();
      showToast(data.message || 'Added to cart!', 'success');
    } catch (err) {
      showToast(err.data?.message || 'Could not add item.', 'error');
    } finally {
      if (btn) { btn.disabled = false; btn.querySelector('.spinner')?.remove(); }
    }
  }

  async function removeItem(itemId) {
    try {
      const data = await apiFetch(`/api/v1/cart/${itemId}`, { method: 'DELETE' });
      updateBadge(data.cart_count);
      CartDrawer.refresh();
    } catch (err) {
      showToast('Could not remove item.', 'error');
    }
  }

  async function updateQty(itemId, qty) {
    if (qty < 1) return removeItem(itemId);
    try {
      const data = await apiFetch(`/api/v1/cart/${itemId}`, {
        method: 'PATCH',
        body: JSON.stringify({ quantity: qty }),
      });
      updateBadge(data.cart_count);
      CartDrawer.refresh();
    } catch (err) {
      showToast('Could not update cart.', 'error');
    }
  }

  return { addItem, removeItem, updateQty, updateBadge };
})();

/* ── Cart Drawer ─────────────────────────────────────────── */
const CartDrawer = (() => {
  let overlay, drawer;

  function init() {
    overlay = $('#cartDrawerOverlay');
    drawer  = $('#cartDrawer');
    if (!overlay || !drawer) return;

    $('#cartToggle')?.addEventListener('click', open);
    overlay.addEventListener('click', close);
    drawer.addEventListener('click', e => {
      if (e.target.closest('[data-remove-item]')) {
        Cart.removeItem(e.target.closest('[data-remove-item]').dataset.removeItem);
      }
    });
    document.addEventListener('keydown', e => { if (e.key === 'Escape') close(); });
  }

  function open() {
    overlay.classList.add('open');
    drawer.classList.add('open');
    drawer.setAttribute('aria-hidden', 'false');
    $('#cartToggle')?.setAttribute('aria-expanded', 'true');
    document.body.style.overflow = 'hidden';
    refresh();
  }

  function close() {
    overlay.classList.remove('open');
    drawer.classList.remove('open');
    drawer.setAttribute('aria-hidden', 'true');
    $('#cartToggle')?.setAttribute('aria-expanded', 'false');
    document.body.style.overflow = '';
  }

  async function refresh() {
    const body = $('#cartDrawerBody');
    if (!body) return;
    try {
      const data = await apiFetch('/api/v1/cart');
      renderItems(data);
    } catch {/* silent */}
  }

  function renderItems(data) {
    const body = $('#cartDrawerBody');
    const footer = $('#cartDrawerFooter');
    if (!body) return;

    if (!data.items?.length) {
      body.innerHTML = '<div class="cart-empty"><p>Your cart is empty.</p></div>';
      if (footer) footer.hidden = true;
      return;
    }

    body.innerHTML = data.items.map(item => `
      <div class="cart-item">
        <img class="cart-item__image" src="${item.image || '/assets/images/placeholder.webp'}" alt="${item.name}">
        <div class="cart-item__info">
          <p class="cart-item__name">${item.name}</p>
          ${item.variant ? `<p class="cart-item__variant">${item.variant}</p>` : ''}
          <p class="cart-item__price">${item.price_formatted}</p>
        </div>
        <button class="btn btn--ghost btn--sm" data-remove-item="${item.id}" aria-label="Remove ${item.name}">✕</button>
      </div>
    `).join('');

    if (footer) {
      footer.hidden = false;
      const totalsEls = footer.querySelectorAll('.cart-total-value');
      if (totalsEls.length > 0) {
        totalsEls.forEach(el => el.textContent = data.subtotal_formatted || data.total_formatted);
      }
    }
  }

  return { init, open, close, refresh };
})();

/* ── Add to Cart form (product detail) ───────────────────── */
function initAddToCart() {
  const form = $('#addToCartForm');
  if (!form) return;

  form.addEventListener('submit', e => {
    e.preventDefault();
    const productId = form.dataset.productId;
    const variantId = form.querySelector('#inputVariantId')?.value || null;
    const qty       = parseInt(form.querySelector('#qtyInput')?.value) || 1;
    Cart.addItem(productId, variantId, qty);
  });
}

/* ── Qty stepper ─────────────────────────────────────────── */
function initQtyStepper() {
  document.addEventListener('click', e => {
    const dec = e.target.closest('.qty-dec');
    const inc = e.target.closest('.qty-inc');
    if (!dec && !inc) return;

    const wrap  = (dec || inc).closest('.qty-stepper');
    const input = wrap?.querySelector('.qty-input');
    if (!input) return;

    const min = parseInt(input.min) || 1;
    const max = parseInt(input.max) || 9999;
    let val = parseInt(input.value) || 1;

    if (dec) val = Math.max(min, val - 1);
    if (inc) val = Math.min(max, val + 1);

    input.value = val;
    input.dispatchEvent(new Event('change'));
  });
}

/* ── Variant selector ────────────────────────────────────── */
function initVariantSelector() {
  const selector = $('#variantSelector');
  if (!selector) return;

  selector.addEventListener('click', e => {
    const btn = e.target.closest('.variant-btn:not(:disabled)');
    if (!btn) return;

    $$('.variant-btn', selector).forEach(b => b.setAttribute('aria-pressed', 'false'));
    btn.setAttribute('aria-pressed', 'true');

    const variantId = btn.dataset.variantId;
    const price     = btn.dataset.price;
    const stock     = parseInt(btn.dataset.stock);

    $('#inputVariantId').value = variantId;

    // Update displayed price
    const priceEl = $('.product-price .price');
    if (priceEl && price) priceEl.textContent = new Intl.NumberFormat('de-DE', { style: 'currency', currency: 'EUR' }).format(price);

    // Update max qty
    const qtyInput = $('#qtyInput');
    if (qtyInput) qtyInput.max = stock || 999;

    // Update add to cart button
    const addBtn = $('.add-to-cart-btn');
    if (addBtn) addBtn.disabled = (stock <= 0);
  });
}

/* ── Product gallery ─────────────────────────────────────── */
function initGallery() {
  const mainImg = $('#mainImage');
  if (!mainImg) return;

  document.addEventListener('click', e => {
    const thumb = e.target.closest('.gallery-thumb');
    if (!thumb) return;

    $$('.gallery-thumb').forEach(t => { t.classList.remove('active'); t.setAttribute('aria-current', 'false'); });
    thumb.classList.add('active');
    thumb.setAttribute('aria-current', 'true');

    const src = thumb.dataset.src;
    mainImg.style.opacity = '0';
    setTimeout(() => { mainImg.src = src; mainImg.style.opacity = '1'; }, 150);
  });
}

/* ── Tab panel ───────────────────────────────────────────── */
function initTabs() {
  $$('[role="tablist"]').forEach(tablist => {
    const tabs    = $$('[role="tab"]', tablist);
    const panels  = tabs.map(t => $('#' + t.getAttribute('aria-controls')));

    function activateTab(tab) {
      tabs.forEach((t, i) => {
        const active = t === tab;
        t.setAttribute('aria-selected', active);
        t.setAttribute('tabindex', active ? '0' : '-1');
        if (panels[i]) panels[i].hidden = !active;
      });
    }

    tabs.forEach(tab => {
      tab.addEventListener('click', () => activateTab(tab));
      tab.addEventListener('keydown', e => {
        const idx  = tabs.indexOf(document.activeElement);
        if (e.key === 'ArrowRight') tabs[(idx + 1) % tabs.length]?.focus();
        if (e.key === 'ArrowLeft')  tabs[(idx - 1 + tabs.length) % tabs.length]?.focus();
        if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); activateTab(tab); }
      });
    });
  });
}

/* ── Search suggestions ──────────────────────────────────── */
function initSearch() {
  const toggle    = $('#searchToggle');
  const searchBar = $('#searchBar');
  const input     = $('#siteSearch');
  const suggest   = $('#searchSuggestions');

  toggle?.addEventListener('click', () => {
    const open = searchBar.hidden;
    searchBar.hidden = !open;
    toggle.setAttribute('aria-expanded', open);
    if (open) { input?.focus(); }
  });

  if (!input || !suggest) return;

  let timer;
  input.addEventListener('input', () => {
    clearTimeout(timer);
    const q = input.value.trim();
    if (q.length < 2) { suggest.innerHTML = ''; return; }
    timer = setTimeout(async () => {
      try {
        const data = await apiFetch(`/api/v1/products/search?q=${encodeURIComponent(q)}`);
        suggest.innerHTML = (data.data || []).slice(0, 6).map(p => `
          <a href="/${App.lang}/products/${p.url_slug}" class="suggestion-item" role="option">
            ${p.primary_image ? `<img src="${p.primary_image}" width="36" height="36" alt="">` : ''}
            <span class="suggestion-name">${p.name}</span>
            <span class="suggestion-price">${p.price}</span>
          </a>`).join('') || '<p class="suggestion-empty">No results found.</p>';
      } catch {/* silent */}
    }, 300);
  });

  document.addEventListener('click', e => {
    if (!e.target.closest('#searchBar')) { suggest.innerHTML = ''; }
  });
}

/* ── Mobile navigation ───────────────────────────────────── */
function initMobileNav() {
  const btn  = $('.mobile-menu-btn');
  const menu = $('#mobileMenu');
  if (!btn || !menu) return;

  btn.addEventListener('click', () => {
    const open = menu.hidden;
    menu.hidden = !open;
    btn.setAttribute('aria-expanded', !open);
  });
}

/* ── Flash message dismiss ───────────────────────────────── */
function initFlashDismiss() {
  document.addEventListener('click', e => {
    const btn = e.target.closest('.flash-close');
    if (btn) btn.closest('.flash')?.remove();
  });
}

/* ── Product card quick-add ──────────────────────────────── */
function initQuickAdd() {
  document.addEventListener('click', e => {
    const btn = e.target.closest('[data-quick-add]');
    if (!btn) return;
    const productId = btn.dataset.quickAdd;
    Cart.addItem(productId, null, 1);
  });
}

/* ── Init ─────────────────────────────────────────────────── */
document.addEventListener('DOMContentLoaded', () => {
  CartDrawer.init();
  initAddToCart();
  initQtyStepper();
  initVariantSelector();
  initGallery();
  initTabs();
  initSearch();
  initMobileNav();
  initFlashDismiss();
  initQuickAdd();
});

/* ── Toast CSS (injected dynamically) ───────────────────────*/
const toastStyles = `
.toast-container { position: fixed; bottom: 24px; right: 24px; z-index: 9999; display: flex; flex-direction: column; gap: 10px; pointer-events: none; }
.toast { display: flex; align-items: center; justify-content: space-between; gap: 12px; min-width: 280px; max-width: 380px; padding: 14px 18px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,.15); font-size: 14px; font-weight: 500; pointer-events: all; transform: translateX(120%); transition: transform .3s cubic-bezier(.4,0,.2,1); }
.toast.show { transform: translateX(0); }
.toast--success { background: #d1fae5; color: #065f46; border-left: 4px solid #10b981; }
.toast--error   { background: #fee2e2; color: #991b1b; border-left: 4px solid #ef4444; }
.toast--info    { background: #dbeafe; color: #1e40af; border-left: 4px solid #3b82f6; }
.toast-close { background: none; border: none; cursor: pointer; font-size: 16px; opacity: .6; padding: 0 0 0 8px; color: inherit; }
.toast-close:hover { opacity: 1; }
.suggestion-item { display: flex; align-items: center; gap: 10px; padding: 8px 12px; text-decoration: none; color: #374151; transition: background .15s; border-radius: 8px; }
.suggestion-item:hover { background: #f3f4f6; text-decoration: none; }
.suggestion-item img { border-radius: 6px; object-fit: cover; flex-shrink: 0; }
.suggestion-name { flex: 1; font-size: 13px; }
.suggestion-price { font-weight: 600; font-size: 13px; color: #1a56db; }
.suggestion-empty { padding: 12px; text-align: center; color: #6b7280; font-size: 13px; }
#searchSuggestions { background: white; border: 1px solid #e5e7eb; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,.1); margin-top: 8px; overflow: hidden; }
`;
const styleEl = document.createElement('style');
styleEl.textContent = toastStyles;
document.head.appendChild(styleEl);
