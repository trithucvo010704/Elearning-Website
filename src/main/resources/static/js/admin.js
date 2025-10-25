// ===== GUARD: Check ADMIN role =====
(function checkAdminAccess() {
  const token = localStorage.getItem("token");
  if (!token) {
    alert("⚠️ Bạn cần đăng nhập để truy cập trang này!");
    location.href = "/auth.html";
    return;
  }

  try {
    const payload = JSON.parse(atob(token.split(".")[1]));
    const role = payload.role;

    if (role !== "ADMIN") {
      alert("⛔ Access Denied! Chỉ ADMIN mới được truy cập trang này.");
      location.href = "/courses.html";
      return;
    }
  } catch (err) {
    console.error("Invalid token", err);
    localStorage.removeItem("token");
    location.href = "/auth.html";
  }
})();

// ===== Helpers =====
const $ = (s) => document.querySelector(s);
const $$ = (s) => document.querySelectorAll(s);

const TOKEN_KEY = "token";
const getToken = () => localStorage.getItem(TOKEN_KEY);
const clearToken = () => localStorage.removeItem(TOKEN_KEY);

async function api(path, { method = "GET", body } = {}) {
  const headers = {
    "Content-Type": "application/json",
    Accept: "application/json",
    Authorization: `Bearer ${getToken()}`,
  };

  const res = await fetch(`${window.API_BASE}${path}`, {
    method,
    headers,
    body: body ? JSON.stringify(body) : undefined,
  });

  if (!res.ok) {
    if (res.status === 401) {
      clearToken();
      location.href = "/auth.html";
    }

    // Try to parse error, but handle empty response
    try {
      const error = await res.json();
      throw new Error(error.message || `HTTP ${res.status}`);
    } catch (e) {
      throw new Error(`HTTP ${res.status}`);
    }
  }

  // Handle empty response (for DELETE)
  const text = await res.text();
  if (!text || text.trim() === "") {
    return {}; // Return empty object for DELETE success
  }

  try {
    return JSON.parse(text);
  } catch (e) {
    return {}; // Return empty if not valid JSON
  }
}

// ===== Router =====
function route() {
  const h = (location.hash || "#/statistics").toLowerCase();
  $$(".view").forEach((v) => v.classList.remove("active"));
  $$(".nav-link").forEach((l) => l.classList.remove("active"));

  if (h.startsWith("#/users")) {
    $("#view-users").classList.add("active");
    $("#pageTitle").textContent = "Quản Lý Users";
    loadUsers();
  } else if (h.startsWith("#/courses")) {
    $("#view-courses").classList.add("active");
    $("#pageTitle").textContent = "Quản Lý Courses";
    loadCourses();
  } else {
    $("#view-statistics").classList.add("active");
    $("#pageTitle").textContent = "Dashboard";
    loadStatistics();
  }

  $(`a[href="${h}"]`)?.classList.add("active");
}

// ===== Users =====
async function loadUsers() {
  try {
    const users = await api("/api/admin/users");
    $("#userCount").textContent = `${users.length} users`;

    $("#usersList").innerHTML = users
      .map((user) => {
        const roleColors = {
          ADMIN: "danger",
          INSTRUCTOR: "warning",
          STUDENT: "info",
        };
        const roleBadgeClass = roleColors[user.role] || "secondary";

        return `
          <tr>
              <td><strong>${user.id}</strong></td>
              <td>
                <i class="bi bi-person-circle me-2"></i>
                <strong>${user.username}</strong>
              </td>
              <td>${user.fullName || '<span class="text-muted">-</span>'}</td>
              <td>
                  <select onchange="updateUserRole(${user.id}, this.value)" 
                          class="form-select form-select-sm">
                      ${["STUDENT", "INSTRUCTOR", "ADMIN"]
                        .map(
                          (role) =>
                            `<option value="${role}" ${
                              user.role === role ? "selected" : ""
                            }>${role}</option>`
                        )
                        .join("")}
                  </select>
              </td>
              <td>
                  <button onclick="deleteUser(${user.id})" 
                          class="btn btn-danger btn-action btn-sm">
                      <i class="bi bi-trash"></i>
                  </button>
              </td>
          </tr>
        `;
      })
      .join("");
  } catch (err) {
    $("#usersList").innerHTML = `
      <tr><td colspan="5" class="text-center text-danger py-4">
        <i class="bi bi-exclamation-circle me-2"></i>Error: ${err.message}
      </td></tr>
    `;
  }
}

async function updateUserRole(userId, role) {
  try {
    await api(`/api/admin/users/${userId}/role`, {
      method: "PUT",
      body: { role },
    });
    showToast("✅ Role đã được cập nhật!", "success");
    loadUsers(); // Reload to update UI
  } catch (err) {
    showToast("❌ " + err.message, "danger");
  }
}

async function deleteUser(userId) {
  if (
    !confirm("Bạn có chắc muốn xóa user này? Hành động này không thể hoàn tác!")
  )
    return;

  try {
    await api(`/api/admin/users/${userId}`, { method: "DELETE" });
    showToast("✅ Đã xóa user thành công!", "success");
    loadUsers(); // Reload list
  } catch (err) {
    showToast("❌ " + err.message, "danger");
  }
}

function showToast(message, type = "info") {
  const toast = document.createElement("div");
  toast.className = `alert alert-${type} position-fixed top-0 end-0 m-3`;
  toast.style.zIndex = "9999";
  toast.innerHTML = message;
  document.body.appendChild(toast);

  setTimeout(() => {
    toast.classList.add("fade");
    setTimeout(() => toast.remove(), 300);
  }, 3000);
}

// ===== Courses =====
async function loadCourses() {
  try {
    const courses = await api("/api/admin/courses");
    $("#courseCount").textContent = `${courses.length} courses`;

    $("#coursesList").innerHTML = courses
      .map(
        (course) => `
          <tr>
              <td><strong>${course.id}</strong></td>
              <td>
                <i class="bi bi-book me-2"></i>
                <strong>${course.title}</strong>
              </td>
              <td>${
                course.instructor?.username ||
                '<span class="text-muted">-</span>'
              }</td>
              <td><strong>${formatPrice(
                course.priceCents,
                course.currency
              )}</strong></td>
              <td>
                  <select onchange="updateCourseStatus(${
                    course.id
                  }, this.value)" 
                          class="form-select form-select-sm">
                      ${["DRAFT", "PUBLISHED", "ARCHIVED"]
                        .map(
                          (status) =>
                            `<option value="${status}" ${
                              course.status === status ? "selected" : ""
                            }>${status}</option>`
                        )
                        .join("")}
                  </select>
              </td>
              <td>
                  <button onclick="deleteCourse(${course.id})" 
                          class="btn btn-danger btn-action btn-sm">
                      <i class="bi bi-trash"></i>
                  </button>
              </td>
          </tr>
      `
      )
      .join("");
  } catch (err) {
    $("#coursesList").innerHTML = `
      <tr><td colspan="6" class="text-center text-danger py-4">
        <i class="bi bi-exclamation-circle me-2"></i>Error: ${err.message}
      </td></tr>
    `;
  }
}

async function updateCourseStatus(courseId, status) {
  try {
    await api(`/api/admin/courses/${courseId}/status`, {
      method: "PUT",
      body: { status },
    });
    showToast("✅ Status course đã được cập nhật!", "success");
    loadCourses();
  } catch (err) {
    showToast("❌ " + err.message, "danger");
  }
}

async function deleteCourse(courseId) {
  if (!confirm("Bạn có chắc muốn xóa course này? Tất cả lessons sẽ bị xóa!"))
    return;

  try {
    await api(`/api/admin/courses/${courseId}`, { method: "DELETE" });
    showToast("✅ Đã xóa course thành công!", "success");
    loadCourses();
  } catch (err) {
    showToast("❌ " + err.message, "danger");
  }
}

// ===== Statistics =====
async function loadStatistics() {
  try {
    const stats = await api("/api/admin/statistics");

    // Update cards with animation
    animateValue("totalUsers", 0, stats.totalUsers || 0, 1000);
    animateValue("totalCourses", 0, stats.totalCourses || 0, 1000);
    animateValue("activeEnrollments", 0, stats.activeEnrollments || 0, 1000);

    $("#totalRevenue").textContent = formatPrice(
      stats.totalRevenue || 0,
      "VND"
    );

    // Load revenue chart
    const revenueData = await api(
      "/api/admin/statistics/revenue?period=monthly"
    );
    renderRevenueChart(revenueData);
  } catch (err) {
    console.error("Error loading statistics:", err);
  }
}

function animateValue(id, start, end, duration) {
  const obj = document.getElementById(id);
  if (!obj) return;

  const range = end - start;
  const increment = range > 0 ? Math.ceil(range / 50) : -1;
  const stepTime = Math.floor(duration / Math.abs(range / increment));
  let current = start;

  const timer = setInterval(() => {
    current += increment;
    if (
      (increment > 0 && current >= end) ||
      (increment < 0 && current <= end)
    ) {
      current = end;
      clearInterval(timer);
    }
    obj.textContent = current.toLocaleString();
  }, stepTime);
}

function renderRevenueChart(data) {
  const ctx = document.getElementById("revenueChart");

  // Fix: Properly destroy chart if exists
  if (
    window.revenueChart &&
    typeof window.revenueChart.destroy === "function"
  ) {
    try {
      window.revenueChart.destroy();
    } catch (e) {
      console.warn("Chart destroy error:", e);
    }
  }

  // Check if Chart.js is loaded
  if (typeof Chart === "undefined") {
    console.error("Chart.js not loaded");
    return;
  }

  window.revenueChart = new Chart(ctx, {
    type: "line",
    data: {
      labels: Object.keys(data.data || {}),
      datasets: [
        {
          label: "Doanh thu (VND)",
          data: Object.values(data.data || {}),
          borderColor: "rgb(102, 126, 234)",
          backgroundColor: "rgba(102, 126, 234, 0.1)",
          tension: 0.4,
          fill: true,
        },
      ],
    },
    options: {
      responsive: true,
      plugins: {
        legend: {
          display: true,
        },
      },
      scales: {
        y: {
          beginAtZero: true,
          ticks: {
            callback: function (value) {
              return new Intl.NumberFormat("vi-VN").format(value) + " đ";
            },
          },
        },
      },
    },
  });
}

// ===== Utilities =====
function formatPrice(cents, currency) {
  const amount = cents / 100;
  return new Intl.NumberFormat("vi-VN", {
    style: "currency",
    currency: currency || "VND",
  }).format(amount);
}

function logout() {
  clearToken();
  location.href = "/auth.html";
}

// ===== Update Clock =====
function updateClock() {
  const now = new Date();
  const timeStr = now.toLocaleTimeString("vi-VN", {
    hour: "2-digit",
    minute: "2-digit",
    second: "2-digit",
  });
  const dateStr = now.toLocaleDateString("vi-VN", {
    weekday: "short",
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
  });

  const el = $("#currentTime");
  if (el) {
    el.textContent = `${dateStr} ${timeStr}`;
  }
}

// ===== Boot =====
window.addEventListener("hashchange", route);
window.addEventListener("DOMContentLoaded", () => {
  route();
  updateClock();
  setInterval(updateClock, 1000); // Update every second
});
