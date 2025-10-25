// ===== Helpers =====
const $ = (s) => document.querySelector(s);
const show = (el) => el?.classList.remove("d-none");
const hide = (el) => el?.classList.add("d-none");

const Toast = (() => {
  const el = $("#toast"),
    body = $("#toastMsg");
  const t = bootstrap.Toast.getOrCreateInstance(el, { delay: 3200 });
  return (msg, type = "danger") => {
    el.className = `toast text-bg-${type} border-0`;
    body.textContent = msg;
    t.show();
  };
})();

const TOKEN_KEY = "token";
const setToken = (t) => localStorage.setItem(TOKEN_KEY, t);
const getToken = () => localStorage.getItem(TOKEN_KEY);
const clearToken = () => localStorage.removeItem(TOKEN_KEY);

// Safe JSON parse (server có thể trả HTML error)
async function parseBody(res) {
  const text = await res.text();
  try {
    return JSON.parse(text);
  } catch {
    return { _raw: text };
  }
}

async function api(path, { method = "GET", body, auth = true } = {}) {
  const headers = {
    "Content-Type": "application/json",
    Accept: "application/json",
  };
  if (auth) {
    const t = getToken();
    if (t) headers.Authorization = `Bearer ${t}`;
  }
  const res = await fetch(`${window.API_BASE}${path}`, {
    method,
    headers,
    body: body ? JSON.stringify(body) : undefined,
  });
  const data = await parseBody(res);
  if (!res.ok) {
    const msg = (data && (data.error || data.message)) || `HTTP ${res.status}`;
    if (res.status === 401) {
      clearToken();
      location.hash = "#/login";
    }
    throw new Error(msg);
  }
  return data; // AuthRespone { token, user }
}

// ===== Router =====
function route() {
  const h = (location.hash || "#/login").toLowerCase();
  document.querySelectorAll(".view").forEach(hide);
  const authed = !!getToken();

  $("#btnLogout").classList.toggle("d-none", !authed);
  $("#navMe").classList.toggle("d-none", !authed);
  $("#navLogin").classList.toggle("d-none", authed);
  $("#navRegister").classList.toggle("d-none", authed);

  if (h.startsWith("#/me")) {
    if (!authed) {
      location.hash = "#/login";
      return;
    }
    show($("#view-me"));
    loadMe();
  } else if (h.startsWith("#/register")) show($("#view-register"));
  else show($("#view-login"));
}

// ===== Events =====
async function onLogin(e) {
  e.preventDefault();
  const u = $("#loginUsername"),
    p = $("#loginPassword");
  u.classList.remove("is-invalid");
  p.classList.remove("is-invalid");
  if (!u.value || u.value.length < 3) {
    u.classList.add("is-invalid");
    return;
  }
  if (!p.value || p.value.length < 6) {
    p.classList.add("is-invalid");
    return;
  }
  try {
    show($("#loginSpinner"));
    const resp = await api("/api/auth/login", {
      method: "POST",
      body: { username: u.value, password: p.value },
      auth: false,
    });
    if (resp.token) setToken(resp.token);
    $("#loginResultJson").textContent = JSON.stringify(resp, null, 2);
    show($("#loginResult"));
    Toast("Đăng nhập thành công", "success");
    location.hash = "#/me";
  } catch (err) {
    $("#loginResultJson").textContent = err.message || "Login failed";
    show($("#loginResult"));
    Toast(err.message || "Login thất bại", "danger");
  } finally {
    hide($("#loginSpinner"));
  }
}

async function onRegister(e) {
  e.preventDefault();
  const u = $("#regUsername"),
    p = $("#regPassword"),
    f = $("#regFullName").value?.trim();
  u.classList.remove("is-invalid");
  p.classList.remove("is-invalid");
  if (!u.value || u.value.length < 3) {
    u.classList.add("is-invalid");
    return;
  }
  if (!p.value || p.value.length < 6) {
    p.classList.add("is-invalid");
    return;
  }
  try {
    show($("#regSpinner"));
    const body = { username: u.value, password: p.value, fullName: f || null };
    const resp = await api("/api/auth/register", {
      method: "POST",
      body,
      auth: false,
    });
    if (resp.token) setToken(resp.token);
    $("#registerResultJson").textContent = JSON.stringify(resp, null, 2);
    show($("#registerResult"));
    Toast("Đăng ký thành công", "success");
    location.hash = "#/me";
  } catch (err) {
    $("#registerResultJson").textContent = err.message || "Register failed";
    show($("#registerResult"));
    Toast(err.message || "Đăng ký thất bại", "danger");
  } finally {
    hide($("#regSpinner"));
  }
}

async function loadMe() {
  hide($("#meContent"));
  show($("#meLoading"));
  try {
    const resp = await api("/api/auth/me");
    const user = resp.user || {};
    $("#meId").textContent = user.id ?? "—";
    $("#meUsername").textContent = user.username ?? "—";
    $("#meFullName").textContent = user.fullName ?? "—";
    $("#meRole").textContent = user.role ?? "—";
    $("#meResultJson").textContent = JSON.stringify(resp, null, 2);
    show($("#meContent"));
  } catch (err) {
    Toast(err.message || "Không tải được hồ sơ", "danger");
    location.hash = "#/login";
  } finally {
    hide($("#meLoading"));
  }
}

function onLogout() {
  clearToken();
  Toast("Đã đăng xuất", "info");
  location.hash = "#/login";
}

// ===== Boot =====
window.addEventListener("hashchange", route);
window.addEventListener("DOMContentLoaded", () => {
  $("#year").textContent = new Date().getFullYear();
  $("#formLogin").addEventListener("submit", onLogin);
  $("#formRegister").addEventListener("submit", onRegister);
  $("#btnLogout").addEventListener("click", onLogout);
  route();
});
