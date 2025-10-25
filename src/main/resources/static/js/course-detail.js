// ===== Helpers =====
const $ = (s) => document.querySelector(s);
const TOKEN_KEY = "token";
const getToken = () => localStorage.getItem(TOKEN_KEY);

let currentCourse = null;
let currentLessons = [];

// ===== API Call =====
async function api(path, { method = "GET", auth = true } = {}) {
  const headers = {
    "Content-Type": "application/json",
  };

  if (auth) {
    const token = getToken();
    if (token) headers.Authorization = `Bearer ${token}`;
  }

  const res = await fetch(`${window.API_BASE}${path}`, { method, headers });
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  return res.json();
}

// ===== Get Course ID from URL =====
function getCourseId() {
  const params = new URLSearchParams(window.location.search);
  return params.get("id");
}

// ===== Load Course Details =====
async function loadCourseDetails() {
  const courseId = getCourseId();
  if (!courseId) {
    window.location.href = "/";
    return;
  }

  try {
    // Load course info (public API không cần auth)
    const courses = await api("/api/courses", { auth: false });
    currentCourse = courses.find((c) => c.id == courseId);

    if (!currentCourse) {
      alert("Khóa học không tồn tại");
      window.location.href = "/";
      return;
    }

    // Update UI
    $("#courseTitle").textContent = currentCourse.title;
    $("#courseDescription").textContent = currentCourse.description || "";

    const isFree = currentCourse.priceCents === 0;
    $("#coursePrice").textContent = isFree
      ? "Miễn phí"
      : formatPrice(currentCourse.priceCents, currentCourse.currency);
    $("#courseBadge").textContent = isFree ? "Miễn phí" : "Trả phí";
    $("#courseBadge").className = `badge ${
      isFree ? "bg-success" : "bg-warning"
    }`;

    // Show enroll button if not free
    if (!isFree) {
      $("#btnEnroll").classList.remove("d-none");
    }

    // Load lessons
    await loadLessons(courseId);
  } catch (err) {
    console.error("Error loading course:", err);
  }
}

// ===== Load Lessons =====
async function loadLessons(courseId) {
  try {
    const lessons = await api(`/api/courses/${courseId}/lessons`, {
      auth: false,
    });
    currentLessons = lessons;

    const list = $("#lessonsList");

    if (lessons.length === 0) {
      list.innerHTML =
        '<div class="p-4 text-center text-muted">Chưa có bài học</div>';
      return;
    }

    list.innerHTML = lessons
      .map(
        (lesson, index) => `
      <div class="list-group-item list-group-item-action lesson-item ${
        !lesson.freePreview ? "locked" : ""
      }" 
           onclick="playLesson(${lesson.id}, ${lesson.freePreview})">
        <div class="d-flex justify-content-between align-items-center">
          <div class="flex-grow-1">
            <div class="fw-semibold">
              <i class="bi bi-play-circle"></i> ${index + 1}. ${lesson.title}
            </div>
            <small class="text-muted">
              <i class="bi bi-clock"></i> ${Math.floor(
                lesson.durationSec / 60
              )} phút
            </small>
          </div>
          <div>
            ${
              lesson.freePreview
                ? '<span class="badge bg-success">Preview</span>'
                : '<i class="bi bi-lock-fill text-warning"></i>'
            }
          </div>
        </div>
      </div>
    `
      )
      .join("");
  } catch (err) {
    console.error("Error loading lessons:", err);
  }
}

// ===== Play Lesson =====
async function playLesson(lessonId, isFreePreview) {
  const courseId = getCourseId();
  const token = getToken();

  // Hide all containers
  $("#videoContainer").classList.add("d-none");
  $("#paywall").classList.add("d-none");
  $("#emptyVideo").classList.add("d-none");
  $("#lessonInfo").classList.add("d-none");

  // Find lesson info
  const lesson = currentLessons.find((l) => l.id === lessonId);
  if (!lesson) return;

  try {
    // Call embed API to check access
    const embed = await api(
      `/api/lessons/${lessonId}/embed?courseId=${courseId}&origin=${window.location.origin}`,
      { auth: true }
    );

    if (embed.canWatch) {
      // Show video player
      $("#videoPlayer").src = embed.embedUrl;
      $("#videoContainer").classList.remove("d-none");

      // Show lesson info
      $("#lessonTitle").textContent = lesson.title;
      $("#lessonDuration").textContent = Math.floor(lesson.durationSec / 60);
      $("#lessonInfo").classList.remove("d-none");

      // Scroll to video
      $("#videoContainer").scrollIntoView({ behavior: "smooth" });
    } else {
      // Show paywall
      $("#paywall").classList.remove("d-none");
    }
  } catch (err) {
    console.error("Error playing lesson:", err);

    // If not logged in, redirect to login
    if (err.message.includes("401")) {
      if (confirm("Bạn cần đăng nhập để xem video này. Đăng nhập ngay?")) {
        window.location.href = "/auth.html#/login";
      }
    } else {
      // Show paywall for other errors
      $("#paywall").classList.remove("d-none");
    }
  }
}

// ===== Enroll Course =====
function enrollCourse() {
  alert(
    "Chức năng thanh toán đang được phát triển!\n\nTrong phiên bản demo này, bạn có thể:\n- Xem các bài học Free Preview\n- Liên hệ Admin để được cấp quyền"
  );
}

// ===== Utilities =====
function formatPrice(cents, currency) {
  const amount = cents / 100;
  return new Intl.NumberFormat("vi-VN", {
    style: "currency",
    currency: currency || "VND",
  }).format(amount);
}

// ===== Check Auth =====
function checkAuth() {
  const token = getToken();
  if (token) {
    try {
      const payload = JSON.parse(atob(token.split(".")[1]));
      $("#userInfo").textContent = `👋 ${payload.sub}`;
      $("#userInfo").classList.remove("d-none");
    } catch (err) {
      console.error("Invalid token", err);
    }
  }
}

// ===== Boot =====
document.addEventListener("DOMContentLoaded", () => {
  checkAuth();
  loadCourseDetails();
});
