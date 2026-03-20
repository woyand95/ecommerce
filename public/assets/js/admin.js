/**
 * admin.js — Admin Panel JavaScript Bundle
 * Sidebar, data tables, page builder (drag & drop), modals, inline editing
 */

'use strict';

const AdminApp = window.AdminApp || {};

const $ = (sel, ctx = document) => ctx.querySelector(sel);
const $$ = (sel, ctx = document) => [...ctx.querySelectorAll(sel)];

async function adminFetch(url, opts = {}) {
  const res = await fetch(url, {
    headers: { 'Content-Type': 'application/json', 'X-CSRF-TOKEN': AdminApp.csrfToken, 'Accept': 'application/json', ...opts.headers },
    ...opts,
  });
  const data = await res.json();
  if (!res.ok) throw Object.assign(new Error(data.message || 'Error'), { data });
  return data;
}

/* ── Toast notifications ─────────────────────────────────── */
function toast(msg, type = 'success') {
  const el = document.createElement('div');
  el.className = `admin-toast admin-toast--${type}`;
  el.innerHTML = `<span>${msg}</span><button onclick="this.parentElement.remove()">✕</button>`;
  $('#adminToastContainer')?.appendChild(el) || (() => {
    const c = document.createElement('div');
    c.id = 'adminToastContainer';
    c.style.cssText = 'position:fixed;top:70px;right:20px;z-index:9999;display:flex;flex-direction:column;gap:8px;';
    document.body.appendChild(c);
    c.appendChild(el);
  })();
  setTimeout(() => el.remove(), 4000);
}

/* ── Sidebar ─────────────────────────────────────────────── */
function initSidebar() {
  const sidebar     = $('#adminSidebar');
  const toggleBtn   = $('#adminMain .mobile-sidebar-toggle');
  const collapseBtn = $('.sidebar-collapse-btn');

  toggleBtn?.addEventListener('click', () => {
    sidebar?.classList.toggle('open');
  });

  collapseBtn?.addEventListener('click', () => {
    document.querySelector('.admin-layout')?.classList.toggle('sidebar-collapsed');
    const collapsed = document.querySelector('.admin-layout')?.classList.contains('sidebar-collapsed');
    localStorage.setItem('adminSidebarCollapsed', collapsed);
  });

  // Restore collapsed state
  if (localStorage.getItem('adminSidebarCollapsed') === 'true') {
    document.querySelector('.admin-layout')?.classList.add('sidebar-collapsed');
  }

  // Active nav link
  const current = location.pathname;
  $$('.admin-nav-link').forEach(link => {
    if (link.getAttribute('href') === current || current.startsWith(link.getAttribute('href') + '/')) {
      link.classList.add('active');
    }
  });
}

/* ── Branch switcher ─────────────────────────────────────── */
function initBranchSwitcher() {
  const sel = $('#branchSwitch');
  sel?.addEventListener('change', async () => {
    try {
      await adminFetch('/admin/branch/switch', { method: 'POST', body: JSON.stringify({ branch_id: sel.value }) });
      location.reload();
    } catch { toast('Branch switch failed.', 'error'); }
  });
}

/* ── Confirm modal ───────────────────────────────────────── */
function confirmModal(message) {
  return new Promise(resolve => {
    const modal = document.createElement('div');
    modal.className = 'modal-overlay';
    modal.innerHTML = `
      <div class="modal" role="dialog" aria-modal="true" aria-labelledby="confirmTitle">
        <div class="modal-header">
          <h3 class="modal-title" id="confirmTitle">Confirm</h3>
        </div>
        <p style="color:#475569;font-size:14px">${message}</p>
        <div class="modal-footer">
          <button class="btn btn--secondary" id="confirmCancel">Cancel</button>
          <button class="btn btn--danger"    id="confirmOk">Confirm</button>
        </div>
      </div>`;
    document.body.appendChild(modal);
    modal.querySelector('#confirmOk').focus();
    modal.querySelector('#confirmOk').addEventListener('click', () => { modal.remove(); resolve(true); });
    modal.querySelector('#confirmCancel').addEventListener('click', () => { modal.remove(); resolve(false); });
    modal.addEventListener('click', e => { if (e.target === modal) { modal.remove(); resolve(false); } });
    document.addEventListener('keydown', function esc(e) { if (e.key === 'Escape') { modal.remove(); resolve(false); document.removeEventListener('keydown', esc); } });
  });
}

/* ── Delete confirmation ─────────────────────────────────── */
function initDeleteButtons() {
  document.addEventListener('click', async e => {
    const btn = e.target.closest('[data-confirm-delete]');
    if (!btn) return;
    e.preventDefault();
    const confirmed = await confirmModal(btn.dataset.confirmDelete || 'Delete this item?');
    if (!confirmed) return;
    const url = btn.href || btn.dataset.url;
    const method = btn.dataset.method || 'DELETE';
    try {
      await adminFetch(url, { method });
      toast('Deleted successfully.');
      btn.closest('[data-table-row]')?.remove() || location.reload();
    } catch { toast('Delete failed.', 'error'); }
  });
}

/* ── Language tabs ───────────────────────────────────────── */
function initLangTabs() {
  $$('.lang-tabs').forEach(tabsEl => {
    const tabs = $$('.lang-tab', tabsEl);
    tabs.forEach(tab => {
      tab.addEventListener('click', () => {
        const lang = tab.dataset.lang;
        tabs.forEach(t => t.classList.toggle('active', t === tab));
        $$('[data-lang-panel]', tabsEl.parentElement).forEach(panel => {
          panel.hidden = panel.dataset.langPanel !== lang;
        });
      });
    });
  });
}

/* ── Image upload preview ────────────────────────────────── */
function initImagePreviews() {
  $$('[data-image-upload]').forEach(input => {
    const preview = $(input.dataset.imageUpload);
    input.addEventListener('change', () => {
      const file = input.files[0];
      if (!file) return;
      const reader = new FileReader();
      reader.onload = e => { if (preview) { preview.src = e.target.result; preview.hidden = false; } };
      reader.readAsDataURL(file);
    });
  });

  // Multi-image upload with preview grid
  $$('[data-multi-upload]').forEach(input => {
    const grid = $(input.dataset.multiUpload);
    input.addEventListener('change', () => {
      if (!grid) return;
      [...input.files].forEach(file => {
        const reader = new FileReader();
        reader.onload = e => {
          const div = document.createElement('div');
          div.className = 'upload-preview-item';
          div.innerHTML = `<img src="${e.target.result}" alt=""><button type="button" class="remove-preview">✕</button>`;
          div.querySelector('.remove-preview').addEventListener('click', () => div.remove());
          grid.appendChild(div);
        };
        reader.readAsDataURL(file);
      });
    });
  });
}

/* ── Slug auto-generator ─────────────────────────────────── */
function initSlugGenerator() {
  $$('[data-slug-source]').forEach(sourceInput => {
    const target = $(sourceInput.dataset.slugSource);
    let manual = false;
    target?.addEventListener('input', () => { manual = true; });
    sourceInput.addEventListener('input', () => {
      if (manual) return;
      const slug = sourceInput.value.toLowerCase()
        .replace(/[äöü]/g, c => ({ ä: 'ae', ö: 'oe', ü: 'ue' }[c]))
        .replace(/ß/g, 'ss')
        .replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
      if (target) target.value = slug;
    });
  });
}

/* ── Data table: search filter ───────────────────────────── */
function initTableSearch() {
  $$('[data-table-search]').forEach(input => {
    const tableId = input.dataset.tableSearch;
    const table   = $(`#${tableId}`);
    const rows    = $$('tbody tr', table);

    input.addEventListener('input', () => {
      const q = input.value.toLowerCase();
      rows.forEach(row => {
        row.hidden = !row.textContent.toLowerCase().includes(q);
      });
    });
  });
}

/* ── Sortable table headers ──────────────────────────────── */
function initSortableTable() {
  $$('th.sortable').forEach(th => {
    th.addEventListener('click', () => {
      const table = th.closest('table');
      const idx   = [...th.parentElement.children].indexOf(th);
      const asc   = th.dataset.sort !== 'asc';
      $$('th.sortable', table).forEach(h => delete h.dataset.sort);
      th.dataset.sort = asc ? 'asc' : 'desc';

      const rows = [...$$('tbody tr', table)].filter(r => !r.hidden);
      rows.sort((a, b) => {
        const va = a.children[idx]?.textContent.trim() || '';
        const vb = b.children[idx]?.textContent.trim() || '';
        return asc ? va.localeCompare(vb, undefined, { numeric: true }) : vb.localeCompare(va, undefined, { numeric: true });
      });
      rows.forEach(r => table.querySelector('tbody').appendChild(r));
    });
  });
}

/* ── Status quick-update ─────────────────────────────────── */
function initStatusUpdate() {
  document.addEventListener('change', async e => {
    const sel = e.target.closest('[data-status-update]');
    if (!sel) return;
    const url    = sel.dataset.statusUpdate;
    const status = sel.value;
    try {
      await adminFetch(url, { method: 'PATCH', body: JSON.stringify({ status }) });
      toast('Status updated.', 'success');
      // Update badge in same row
      const badge = sel.closest('tr')?.querySelector('.badge');
      if (badge) {
        badge.className = `badge badge--${statusBadgeClass(status)}`;
        badge.textContent = status;
      }
    } catch { toast('Update failed.', 'error'); sel.value = sel.dataset.original; }
  });

  $$('[data-status-update]').forEach(sel => { sel.dataset.original = sel.value; });
}

function statusBadgeClass(status) {
  const map = { confirmed: 'info', processing: 'warning', shipped: 'info', delivered: 'success', cancelled: 'danger', refunded: 'gray', pending: 'warning', approved: 'success', rejected: 'danger' };
  return map[status] || 'gray';
}

/* ── Page Builder ────────────────────────────────────────── */
const PageBuilder = (() => {
  let canvas, blockList = [];

  function init() {
    canvas = $('#builderCanvas');
    if (!canvas) return;

    // Load existing blocks from data attribute
    try { blockList = JSON.parse(canvas.dataset.blocks || '[]'); } catch { blockList = []; }
    render();

    // Add block from palette
    $$('.palette-btn').forEach(btn => {
      btn.addEventListener('click', () => addBlock(btn.dataset.blockType));
    });

    // Drag-and-drop reordering
    initDragDrop();
  }

  function addBlock(type) {
    const block = { id: Date.now(), type, is_active: true, css_class: '', settings: {}, content: { de: '', en: '' } };
    blockList.push(block);
    render();
  }

  function removeBlock(id) {
    blockList = blockList.filter(b => b.id !== id);
    render();
  }

  function render() {
    if (!canvas) return;

    if (!blockList.length) {
      canvas.classList.add('empty');
      canvas.innerHTML = `
        <svg width="48" height="48" fill="none" stroke="#94a3b8" stroke-width="1.5"><rect x="8" y="8" width="32" height="32" rx="4"/><path d="M24 16v16M16 24h16"/></svg>
        <p>Drag blocks from the palette to build your page</p>`;
      return;
    }

    canvas.classList.remove('empty');
    canvas.innerHTML = blockList.map((block, idx) => `
      <div class="builder-block" data-block-id="${block.id}" draggable="true">
        <div class="block-handle" aria-label="Drag to reorder">
          <span class="block-type-label">
            <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"><circle cx="5" cy="5" r="1.5"/><circle cx="5" cy="9" r="1.5"/><circle cx="9" cy="5" r="1.5"/><circle cx="9" cy="9" r="1.5"/></svg>
            ${block.type.toUpperCase()}
          </span>
          <div class="block-actions">
            <button type="button" class="action-btn" onclick="PageBuilder.toggleActive('${block.id}')" title="Toggle visibility" aria-label="Toggle">
              ${block.is_active ? '👁' : '🚫'}
            </button>
            <button type="button" class="action-btn danger" onclick="PageBuilder.remove('${block.id}')" title="Remove block" aria-label="Remove block">✕</button>
          </div>
        </div>
        <div class="block-body">
          ${renderBlockEditor(block)}
        </div>
      </div>`).join('');

    syncHiddenInput();
  }

  function renderBlockEditor(block) {
    const langs = ['de', 'en'];
    const tabsHtml = langs.map(l => `<button type="button" class="lang-tab ${l==='de'?'active':''}" onclick="switchBlockLang(this,'${block.id}','${l}')">${l.toUpperCase()}</button>`).join('');

    const editorsHtml = langs.map(l => `
      <div data-block-lang="${l}" style="${l==='de'?'':'display:none'}">
        ${block.type === 'text' || block.type === 'html'
          ? `<textarea class="form-textarea" rows="4" onchange="PageBuilder.updateContent('${block.id}','${l}',this.value)" placeholder="Content (${l})">${(block.content[l]||'').replace(/</g,'&lt;')}</textarea>`
          : `<input class="form-input" type="text" onchange="PageBuilder.updateContent('${block.id}','${l}',this.value)" value="${(block.content[l]||'').replace(/"/g,'&quot;')}" placeholder="Content (${l})">`}
      </div>`).join('');

    return `
      <div class="lang-tabs" style="margin-bottom:12px">${tabsHtml}</div>
      ${editorsHtml}
      <div style="margin-top:12px">
        <input class="form-input form-input--sm" type="text" placeholder="CSS class (optional)"
               value="${block.css_class||''}" onchange="PageBuilder.updateCss('${block.id}',this.value)"
               style="font-size:12px;padding:4px 8px;max-width:220px">
      </div>`;
  }

  function syncHiddenInput() {
    const input = $('[name="blocks_json"]');
    if (input) input.value = JSON.stringify(blockList);
  }

  function initDragDrop() {
    let dragId = null;

    canvas.addEventListener('dragstart', e => {
      const block = e.target.closest('.builder-block');
      if (block) { dragId = block.dataset.blockId; block.classList.add('dragging'); }
    });

    canvas.addEventListener('dragend', e => {
      e.target.closest('.builder-block')?.classList.remove('dragging');
      canvas.classList.remove('drag-over');
      dragId = null;
    });

    canvas.addEventListener('dragover', e => {
      e.preventDefault(); canvas.classList.add('drag-over');
      const afterEl = getDragAfterElement(canvas, e.clientY);
      const dragging = canvas.querySelector('.dragging');
      if (dragging && afterEl) canvas.insertBefore(dragging, afterEl);
      else if (dragging) canvas.appendChild(dragging);
    });

    canvas.addEventListener('dragleave', () => canvas.classList.remove('drag-over'));

    canvas.addEventListener('drop', () => {
      canvas.classList.remove('drag-over');
      // Re-sync order from DOM
      const newOrder = $$('.builder-block', canvas).map(el => el.dataset.blockId);
      blockList.sort((a, b) => newOrder.indexOf(String(a.id)) - newOrder.indexOf(String(b.id)));
      syncHiddenInput();
    });
  }

  function getDragAfterElement(container, y) {
    const els = $$('.builder-block:not(.dragging)', container);
    return els.reduce((closest, child) => {
      const box    = child.getBoundingClientRect();
      const offset = y - box.top - box.height / 2;
      return (offset < 0 && offset > closest.offset) ? { offset, element: child } : closest;
    }, { offset: Number.NEGATIVE_INFINITY }).element;
  }

  function updateContent(id, lang, val) {
    const block = blockList.find(b => String(b.id) === String(id));
    if (block) { block.content[lang] = val; syncHiddenInput(); }
  }

  function updateCss(id, val) {
    const block = blockList.find(b => String(b.id) === String(id));
    if (block) { block.css_class = val; syncHiddenInput(); }
  }

  function toggleActive(id) {
    const block = blockList.find(b => String(b.id) === String(id));
    if (block) { block.is_active = !block.is_active; render(); }
  }

  function remove(id) { removeBlock(id); }

  return { init, remove, toggleActive, updateContent, updateCss };
})();

/* block lang switcher (global for onclick) */
window.switchBlockLang = function(btn, blockId, lang) {
  const blockEl = btn.closest('.builder-block');
  $$('.lang-tab', blockEl).forEach(t => t.classList.remove('active'));
  btn.classList.add('active');
  $$('[data-block-lang]', blockEl).forEach(p => p.style.display = p.dataset.blockLang === lang ? '' : 'none');
};
window.PageBuilder = PageBuilder;

/* ── Inline toggle (active/inactive) ─────────────────────── */
function initToggleSwitches() {
  document.addEventListener('change', async e => {
    const toggle = e.target.closest('[data-toggle-url]');
    if (!toggle) return;
    try {
      await adminFetch(toggle.dataset.toggleUrl, { method: 'PATCH', body: JSON.stringify({ [toggle.dataset.toggleField || 'is_active']: toggle.checked ? 1 : 0 }) });
    } catch { toast('Failed to update.', 'error'); toggle.checked = !toggle.checked; }
  });
}

/* ── Bulk selection ──────────────────────────────────────── */
function initBulkSelect() {
  const checkAll = $('#checkAll');
  if (!checkAll) return;

  checkAll.addEventListener('change', () => {
    $$('.row-check').forEach(cb => cb.checked = checkAll.checked);
    updateBulkBar();
  });

  document.addEventListener('change', e => {
    if (e.target.classList.contains('row-check')) updateBulkBar();
  });

  function updateBulkBar() {
    const checked = $$('.row-check:checked').length;
    const bar = $('#bulkActionBar');
    if (bar) { bar.hidden = checked === 0; bar.querySelector('[data-count]').textContent = checked; }
  }

  $('#bulkActionApply')?.addEventListener('click', async () => {
    const action  = $('#bulkAction')?.value;
    const ids     = $$('.row-check:checked').map(cb => cb.value);
    const url     = $('#bulkActionBar')?.dataset.url;
    if (!action || !ids.length || !url) return;
    const ok = await confirmModal(`Apply "${action}" to ${ids.length} items?`);
    if (!ok) return;
    try {
      await adminFetch(url, { method: 'POST', body: JSON.stringify({ action, ids }) });
      toast('Bulk action applied.', 'success');
      location.reload();
    } catch { toast('Bulk action failed.', 'error'); }
  });
}

/* ── Document review (B2B) ───────────────────────────────── */
function initDocumentReview() {
  document.addEventListener('click', async e => {
    const btn = e.target.closest('[data-doc-action]');
    if (!btn) return;
    const { docAction, docId } = btn.dataset;
    const confirmed = await confirmModal(`Mark document as "${docAction}"?`);
    if (!confirmed) return;
    try {
      await adminFetch(`/admin/documents/${docId}`, { method: 'PATCH', body: JSON.stringify({ status: docAction }) });
      toast(`Document ${docAction}.`, 'success');
      btn.closest('[data-doc-row]')?.querySelector('.badge')?.classList.replace('badge--warning', `badge--${docAction === 'accepted' ? 'success' : 'danger'}`);
    } catch { toast('Action failed.', 'error'); }
  });
}

/* ── Init ─────────────────────────────────────────────────── */
document.addEventListener('DOMContentLoaded', () => {
  initSidebar();
  initBranchSwitcher();
  initDeleteButtons();
  initLangTabs();
  initImagePreviews();
  initSlugGenerator();
  initTableSearch();
  initSortableTable();
  initStatusUpdate();
  initToggleSwitches();
  initBulkSelect();
  initDocumentReview();
  PageBuilder.init();
});

/* ── Admin toast CSS ─────────────────────────────────────── */
const adminToastCss = `
.admin-toast { display:flex;align-items:center;justify-content:space-between;gap:12px;padding:12px 16px;border-radius:8px;font-size:13px;font-weight:500;box-shadow:0 4px 12px rgba(0,0,0,.15);animation:slideInRight .25s ease; }
.admin-toast--success { background:#d1fae5;color:#065f46;border-left:3px solid #10b981; }
.admin-toast--error   { background:#fee2e2;color:#991b1b;border-left:3px solid #ef4444; }
.admin-toast button { background:none;border:none;cursor:pointer;font-size:14px;opacity:.6;color:inherit; }
.admin-toast button:hover { opacity:1; }
@keyframes slideInRight { from{transform:translateX(50px);opacity:0} to{transform:translateX(0);opacity:1} }
.upload-preview-item { position:relative;width:80px;height:80px; }
.upload-preview-item img { width:100%;height:100%;object-fit:cover;border-radius:8px;border:1px solid #e2e8f0; }
.upload-preview-item .remove-preview { position:absolute;top:-6px;right:-6px;background:white;border:1px solid #e2e8f0;border-radius:50%;width:20px;height:20px;font-size:10px;cursor:pointer;display:flex;align-items:center;justify-content:center;box-shadow:0 1px 3px rgba(0,0,0,.1); }
.sidebar-collapsed .admin-sidebar { width:60px; }
.sidebar-collapsed .logo-text,
.sidebar-collapsed .admin-nav-link span,
.sidebar-collapsed .nav-group-label,
.sidebar-collapsed .branch-selector-wrap { display:none; }
.sidebar-collapsed .admin-nav-link { justify-content:center;padding:8px; }
.sidebar-collapsed .admin-main { grid-column:1; }
`;
const adminStyleEl = document.createElement('style');
adminStyleEl.textContent = adminToastCss;
document.head.appendChild(adminStyleEl);
