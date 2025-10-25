// ===== Helpers =====
const $ = (s) => document.querySelector(s);
const $$ = (s) => document.querySelectorAll(s);

const TOKEN_KEY = "token";
const getToken = () => localStorage.getItem(TOKEN_KEY);
const clearToken = () => localStorage.removeItem(TOKEN_KEY);

// ===== API Call =====
async function api(path, { method = "GET", auth = false } = {}) {
  const headers = {
    "Content-Type": "application/json",
    Accept: "application/json",
  };

  if (auth) {
    const token = getToken();
    if (token) headers.Authorization = `Bearer ${token}`;
  }

  const res = await fetch(`${window.API_BASE}${path}`, { method, headers });

  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  return res.json();
}

// ===== Check Authentication =====
function checkAuth() {
  const token = getToken();

  if (token) {
    try {
      // Decode JWT to get user info
      const payload = JSON.parse(atob(token.split(".")[1]));
      const role = payload.role;
      const username = payload.sub;

      // Update UI for logged in user
      $("#userInfo").textContent = `👋 ${username} (${role})`;
      $("#userInfo").classList.remove("d-none");
      $("#btnLogin").classList.add("d-none");
      $("#btnRegister").classList.add("d-none");
      $("#btnLogout").classList.remove("d-none");

      // Show dashboard button based on role
      const dashboard = $("#btnDashboard");
      if (role === "ADMIN") {
        dashboard.href = "/admin.html";
        dashboard.innerHTML =
          '<i class="bi bi-shield-fill"></i> Admin Dashboard';
        dashboard.classList.remove("d-none");
      } else if (role === "INSTRUCTOR") {
        dashboard.href = "/courses.html";
        dashboard.innerHTML = '<i class="bi bi-book-fill"></i> My Courses';
        dashboard.classList.remove("d-none");
      }
    } catch (err) {
      console.error("Invalid token", err);
      clearToken();
    }
  }
}

// ===== Load Courses =====
async function loadCourses() {
  const grid = $("#coursesGrid");
  const loading = $("#coursesLoading");
  const empty = $("#coursesEmpty");

  try {
    const courses = await api("/api/courses");

    loading.classList.add("d-none");

    if (courses.length === 0) {
      empty.classList.remove("d-none");
      return;
    }

    grid.innerHTML = courses.map((course) => createCourseCard(course)).join("");
    grid.classList.remove("d-none");

    // Update stats
    $("#statCourses").textContent = courses.length;
  } catch (err) {
    console.error("Error loading courses:", err);
    loading.classList.add("d-none");
    empty.classList.remove("d-none");
  }
}

// ===== Create Course Card =====
function createCourseCard(course) {
  const isFree = course.priceCents === 0;
  const price = isFree
    ? "Miễn phí"
    : formatPrice(course.priceCents, course.currency);

  return `
    <div class="col-md-6 col-lg-4">
      <div class="card course-card h-100 shadow-sm">
        <div class="position-relative">
          ${
            course.thumbnailUrl
              ? `<img src="${course.thumbnailUrl}" class="card-img-top course-thumbnail" alt="${course.title}">`
              : `<div class="course-thumbnail d-flex align-items-center justify-content-center">
                 <i class="bi bi-book fs-1 text-white"></i>
               </div>`
          }
          ${isFree ? '<span class="badge-free">Miễn phí</span>' : ""}
        </div>
        <div class="card-body d-flex flex-column">
          <h5 class="card-title">${escapeHtml(course.title)}</h5>
          <p class="card-text text-muted flex-grow-1">${escapeHtml(
            course.description || ""
          ).substring(0, 100)}${
    course.description?.length > 100 ? "..." : ""
  }</p>
          <div class="d-flex justify-content-between align-items-center mt-3">
            <span class="h5 mb-0 text-primary">${price}</span>
            <a href="/course.html?id=${course.id}" class="btn btn-primary">
              Xem chi tiết <i class="bi bi-arrow-right"></i>
            </a>
          </div>
        </div>
      </div>
    </div>
  `;
}

// ===== Filter Courses =====
let allCourses = [];

async function filterCourses(filter) {
  // Update active button
  $$(".btn-group button").forEach((btn) => btn.classList.remove("active"));
  event.target.classList.add("active");

  const grid = $("#coursesGrid");
  let filtered = allCourses;

  if (filter === "free") {
    filtered = allCourses.filter((c) => c.priceCents === 0);
  } else if (filter === "paid") {
    filtered = allCourses.filter((c) => c.priceCents > 0);
  }

  grid.innerHTML = filtered.map((course) => createCourseCard(course)).join("");
}

// ===== Load Stats =====
async function loadStats() {
  try {
    const courses = await api("/api/courses");
    allCourses = courses;

    $("#statCourses").textContent = courses.length;

    // Animated counter (giả lập)
    animateValue("statStudents", 0, 1234, 2000);
    animateValue("statInstructors", 0, 56, 2000);
    animateValue("statHours", 0, 12500, 2000);
  } catch (err) {
    console.error("Error loading stats:", err);
  }
}

// ===== Utilities =====
function formatPrice(cents, currency) {
  const amount = cents / 100;
  return new Intl.NumberFormat("vi-VN", {
    style: "currency",
    currency: currency || "VND",
  }).format(amount);
}

function escapeHtml(text) {
  const div = document.createElement("div");
  div.textContent = text;
  return div.innerHTML;
}

function animateValue(id, start, end, duration) {
  const obj = document.getElementById(id);
  const range = end - start;
  const increment = end > start ? 1 : -1;
  const stepTime = Math.abs(Math.floor(duration / range));
  let current = start;

  const timer = setInterval(() => {
    current += increment;
    obj.textContent = current.toLocaleString();
    if (current === end) clearInterval(timer);
  }, stepTime);
}

function logout() {
  clearToken();
  location.reload();
}

// ===== Boot =====
document.addEventListener("DOMContentLoaded", () => {
  $("#year").textContent = new Date().getFullYear();
  $("#btnLogout")?.addEventListener("click", logout);

  checkAuth();
  loadCourses();
  loadStats();
});
