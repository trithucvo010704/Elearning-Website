// ===== GUARD: Check INSTRUCTOR/ADMIN role =====
(function checkInstructorAccess() {
  const token = localStorage.getItem("token");
  if (!token) {
    showToast("⚠️ Bạn cần đăng nhập!", "warning");
    setTimeout(() => (location.href = "/auth.html"), 2000);
    return;
  }

  try {
    const payload = JSON.parse(atob(token.split(".")[1]));
    const role = payload.role;
    const validRoles = ["INSTRUCTOR", "ADMIN"];

    if (!validRoles.includes(role)) {
      showToast(
        "⛔ Chỉ Instructor/Admin mới truy cập được trang này.",
        "danger"
      );
      setTimeout(() => (location.href = "/auth.html"), 2000);
      return;
    }

    // Set user info in navbar
    const userName = payload.fullName || payload.username || "User";
    document.getElementById("userName").textContent = userName;
  } catch (err) {
    console.error("Invalid token", err);
    localStorage.removeItem("token");
    location.href = "/auth.html";
  }
})();

// ===== Constants & Helpers =====
const API_BASE = "/api";
const TOKEN_KEY = "token";

// Get stored JWT token
const getToken = () => localStorage.getItem(TOKEN_KEY);
const clearToken = () => localStorage.removeItem(TOKEN_KEY);

// Handle API calls with authentication
async function api(path, { method = "GET", body } = {}) {
  const headers = {
    "Content-Type": "application/json",
    Accept: "application/json",
  };

  const token = getToken();
  if (token) {
    headers["Authorization"] = `Bearer ${token}`;
  }

  const res = await fetch(API_BASE + path, {
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

// Show Bootstrap modal
function showModal(id) {
  const modal = new bootstrap.Modal(document.getElementById(id));
  modal.show();
}

// Hide Bootstrap modal
function hideModal(id) {
  const modal = bootstrap.Modal.getInstance(document.getElementById(id));
  modal.hide();
}

// Format price for display
function formatPrice(cents, currency) {
  const amount = cents / 100;
  return new Intl.NumberFormat("vi-VN", {
    style: "currency",
    currency: currency,
  }).format(amount);
}

// ===== Course Management =====
// Load courses
async function loadCourses() {
  try {
    const courses = await api("/courses?mine=true");

    // Update statistics
    updateStatistics(courses);

    if (courses.length === 0) {
      document.getElementById("courseList").innerHTML = "";
      document.getElementById("emptyState").style.display = "block";
      return;
    }

    document.getElementById("emptyState").style.display = "none";

    const html = courses
      .map((course) => {
        const statusClass =
          course.status === "PUBLISHED"
            ? "status-published"
            : course.status === "DRAFT"
            ? "status-draft"
            : "status-archived";
        const statusText =
          course.status === "PUBLISHED"
            ? "Đã xuất bản"
            : course.status === "DRAFT"
            ? "Bản nháp"
            : "Đã lưu trữ";

        return `
          <div class="col-lg-4 col-md-6">
            <div class="course-card">
              <div class="course-thumbnail">
                ${
                  course.thumbnailUrl
                    ? `<img src="${course.thumbnailUrl}" alt="${course.title}">`
                    : `<div class="d-flex align-items-center justify-content-center h-100">
                    <i class="fas fa-book-open fa-3x text-white opacity-50"></i>
                  </div>`
                }
                <div class="course-overlay">
                  <i class="fas fa-play-circle fa-3x text-white"></i>
                </div>
                <div class="course-status ${statusClass}">
                  ${statusText}
                </div>
              </div>
              <div class="course-content">
                <h5 class="course-title">${course.title}</h5>
                <p class="course-description">${course.description}</p>
                <div class="course-price">${formatPrice(
                  course.priceCents,
                  course.currency
                )}</div>
                <div class="course-actions">
                  <button class="btn btn-action btn-primary-action" onclick="viewLessons(${
                    course.id
                  })">
                    <i class="fas fa-list me-1"></i>
                    Xem Bài Học
                  </button>
                  <button class="btn btn-action btn-primary-action" onclick="addLesson(${
                    course.id
                  })">
                    <i class="fas fa-plus me-1"></i>
                    Thêm Bài Học
                  </button>
                  <button class="btn btn-action btn-secondary-action" onclick="editCourse(${
                    course.id
                  })">
                    <i class="fas fa-edit me-1"></i>
                    Chỉnh Sửa
                  </button>
                  <button class="btn btn-action btn-danger-action" onclick="deleteCourse(${
                    course.id
                  })">
                    <i class="fas fa-trash me-1"></i>
                    Xóa
                  </button>
                </div>
              </div>
            </div>
          </div>
        `;
      })
      .join("");

    document.getElementById("courseList").innerHTML = html;
  } catch (err) {
    showToast("Lỗi khi tải danh sách khóa học: " + err.message, "danger");
  }
}

// Update statistics
function updateStatistics(courses) {
  const totalCourses = courses.length;
  const totalLessons = courses.reduce(
    (sum, course) => sum + (course.lessons?.length || 0),
    0
  );
  const totalViews = courses.reduce(
    (sum, course) => sum + (course.views || 0),
    0
  );
  const totalRevenue = courses.reduce(
    (sum, course) => sum + (course.revenue || 0),
    0
  );

  // Animate counters
  animateValue("totalCourses", 0, totalCourses, 1000);
  animateValue("totalLessons", 0, totalLessons, 1000);
  animateValue("totalViews", 0, totalViews, 1000);

  const revenueElement = document.getElementById("totalRevenue");
  if (revenueElement) {
    animateValue("totalRevenue", 0, totalRevenue, 1000, "đ");
  }
}

// Animate counter values
function animateValue(id, start, end, duration, suffix = "") {
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
    obj.textContent = current.toLocaleString() + suffix;
  }, stepTime);
}

// Submit course form
async function submitCourse() {
  const form = document.getElementById("courseForm");
  const formData = new FormData(form);
  const data = Object.fromEntries(formData.entries());

  try {
    await api("/courses", {
      method: "POST",
      body: data,
    });
    hideModal("courseModal");
    showToast("✅ Tạo khóa học thành công!", "success");
    form.reset();
    loadCourses();
  } catch (err) {
    showToast("❌ Lỗi khi tạo khóa học: " + err.message, "danger");
  }
}

// Extract YouTube Video ID from URL or return as-is if already ID
function extractYouTubeVideoId(input) {
  if (!input) return "";
  
  // Remove whitespace
  input = input.trim();
  
  // If already a video ID (no special chars), return as-is
  if (/^[a-zA-Z0-9_-]{6,}$/.test(input)) {
    return input;
  }
  
  // Try to extract from various YouTube URL formats
  const patterns = [
    /(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/|youtube\.com\/v\/)([a-zA-Z0-9_-]{11})/,
    /^([a-zA-Z0-9_-]{11})$/  // Direct video ID
  ];
  
  for (const pattern of patterns) {
    const match = input.match(pattern);
    if (match && match[1]) {
      return match[1];
    }
  }
  
  // If no pattern matches, return original (will fail validation)
  return input;
}

// Add new lesson to course
async function addLesson(courseId) {
  const form = document.getElementById("lessonForm");
  form.courseId.value = courseId;
  
  // Get current lessons to calculate next order index
  try {
    const lessons = await api(`/courses/${courseId}/lessons`);
    
    // Calculate next order index (max + 1)
    let nextOrderIndex = 1;
    if (lessons && lessons.length > 0) {
      const maxOrder = Math.max(...lessons.map(l => l.orderIndex || 0));
      nextOrderIndex = maxOrder + 1;
    }
    
    // Set suggested order index
    form.orderIndex.value = nextOrderIndex;
  } catch (err) {
    console.error("Error loading lessons:", err);
    // Default to 1 if error
    form.orderIndex.value = 1;
  }
  
  showModal("lessonModal");
}

// Submit lesson form
async function submitLesson() {
  const form = document.getElementById("lessonForm");
  const formData = new FormData(form);
  const courseId = formData.get("courseId");
  
  // Extract YouTube Video ID from URL or input
  const youtubeInput = formData.get("youtubeVideoId");
  const videoId = extractYouTubeVideoId(youtubeInput);
  
  // Build data object with proper types
  const data = {
    title: formData.get("title"),
    youtubeVideoId: videoId,
    orderIndex: parseInt(formData.get("orderIndex") || "0", 10),
    durationSec: parseInt(formData.get("durationSec") || "0", 10),
    freePreview: formData.get("freePreview") === "on" // checkbox value is "on" when checked
  };

  // Validate required fields
  if (!data.title || !data.youtubeVideoId) {
    showToast("❌ Vui lòng điền đầy đủ thông tin!", "danger");
    return;
  }

  // Validate YouTube Video ID format
  if (!/^[a-zA-Z0-9_-]{6,}$/.test(data.youtubeVideoId)) {
    showToast("❌ YouTube Video ID không hợp lệ! Vui lòng nhập URL hoặc Video ID hợp lệ.", "danger");
    return;
  }

  if (isNaN(data.orderIndex) || isNaN(data.durationSec)) {
    showToast("❌ Thứ tự và thời lượng phải là số!", "danger");
    return;
  }

  // Check for duplicate orderIndex
  try {
    const existingLessons = await api(`/courses/${courseId}/lessons`);
    const duplicateOrder = existingLessons.find(l => l.orderIndex === data.orderIndex);
    
    if (duplicateOrder) {
      showToast(`❌ Thứ tự ${data.orderIndex} đã tồn tại! Vui lòng chọn thứ tự khác.`, "danger");
      
      // Calculate and suggest next available order
      const maxOrder = Math.max(...existingLessons.map(l => l.orderIndex || 0));
      form.orderIndex.value = maxOrder + 1;
      showToast(`💡 Gợi ý: Thử thứ tự ${maxOrder + 1}`, "info");
      return;
    }
  } catch (err) {
    console.error("Error checking duplicate orderIndex:", err);
    // Continue anyway if check fails
  }

  try {
    await api(`/courses/${courseId}/lessons/manual`, {
      method: "POST",
      body: data,
    });
    hideModal("lessonModal");
    showToast("✅ Thêm bài học thành công!", "success");
    form.reset();
    loadCourses(); // Refresh to update lesson count
  } catch (err) {
    // Handle duplicate entry error
    if (err.message.includes("Duplicate entry") || err.message.includes("duplicate")) {
      showToast("❌ Thứ tự bài học đã tồn tại! Vui lòng chọn số khác.", "danger");
    } else {
      showToast("❌ Lỗi khi thêm bài học: " + err.message, "danger");
    }
  }
}

// Preview video
async function previewVideo(lessonId, courseId) {
  try {
    console.log(
      "Preview video called with lessonId:",
      lessonId,
      "courseId:",
      courseId
    );

    const origin = window.location.origin;
    console.log("Origin:", origin);

    // Sử dụng endpoint preview cho instructor (luôn cho phép xem)
    const embed = await api(
      `/lessons/${lessonId}/preview?courseId=${courseId}&origin=${origin}`
    );

    console.log("Embed response:", embed);

    const frame = document.getElementById("videoFrame");
    if (!frame) {
      showToast("❌ Không tìm thấy video player!", "danger");
      return;
    }

    frame.src = embed.embedUrl;
    showModal("videoModal");
    showToast("✅ Đang tải video...", "info");
  } catch (err) {
    console.error("Error in previewVideo:", err);
    showToast("❌ Lỗi khi tải video: " + err.message, "danger");
  }
}

// Delete course
async function deleteCourse(id) {
  if (
    !confirm("⚠️ Bạn có chắc muốn xóa khóa học này? Tất cả bài học sẽ bị xóa!")
  )
    return;

  try {
    await api(`/courses/${id}`, { method: "DELETE" });
    showToast("✅ Xóa khóa học thành công!", "success");
    loadCourses();
  } catch (err) {
    showToast("❌ Lỗi khi xóa khóa học: " + err.message, "danger");
  }
}

// Modal helpers
function showModal(modalId) {
  const modal = new bootstrap.Modal(document.getElementById(modalId));
  modal.show();
}

function hideModal(modalId) {
  const modal = bootstrap.Modal.getInstance(document.getElementById(modalId));
  if (modal) {
    modal.hide();
  }
}

// Toast notification
function showToast(message, type = "info") {
  const toast = document.createElement("div");
  toast.className = `toast align-items-center text-white bg-${type} border-0`;
  toast.setAttribute("role", "alert");
  toast.innerHTML = `
    <div class="d-flex">
      <div class="toast-body">
        ${message}
      </div>
      <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
    </div>
  `;

  document.querySelector(".toast-container").appendChild(toast);

  const bsToast = new bootstrap.Toast(toast);
  bsToast.show();

  // Auto remove after 5 seconds
  setTimeout(() => {
    if (toast.parentNode) {
      toast.parentNode.removeChild(toast);
    }
  }, 5000);
}

// View lessons for a course
async function viewLessons(courseId) {
  try {
    console.log(
      "View lessons called with courseId:",
      courseId,
      typeof courseId
    );

    // Validate courseId
    if (!courseId) {
      showToast("❌ ID khóa học không hợp lệ!", "danger");
      return;
    }

    const lessons = await api(`/courses/${courseId}/lessons`);
    const lessonsList = document.getElementById("lessonsList");

    if (!lessonsList) {
      showToast("❌ Không tìm thấy container bài học!", "danger");
      return;
    }

    if (lessons.length === 0) {
      lessonsList.innerHTML = `
        <div class="text-center py-4">
          <i class="fas fa-book-open fa-3x text-muted mb-3"></i>
          <h5 class="text-muted">Chưa có bài học nào</h5>
          <p class="text-muted">Hãy thêm bài học đầu tiên cho khóa học này!</p>
        </div>
      `;
    } else {
      lessonsList.innerHTML = lessons
        .map(
          (lesson, index) => `
        <div class="card mb-3">
          <div class="card-body">
            <div class="row align-items-center">
              <div class="col-md-8">
                <h6 class="card-title mb-1">
                  <i class="fas fa-play-circle me-2 text-primary"></i>
                  ${lesson.title}
                </h6>
                <div class="d-flex align-items-center text-muted small">
                  <span class="me-3">
                    <i class="fas fa-sort-numeric-up me-1"></i>
                    Thứ tự: ${lesson.orderIndex}
                  </span>
                  <span class="me-3">
                    <i class="fas fa-clock me-1"></i>
                    ${
                      lesson.durationSec
                        ? Math.floor(lesson.durationSec / 60) + " phút"
                        : "Chưa xác định"
                    }
                  </span>
                  ${
                    lesson.freePreview
                      ? '<span class="badge bg-success">Xem thử miễn phí</span>'
                      : ""
                  }
                </div>
              </div>
              <div class="col-md-4 text-end">
                <button class="btn btn-outline-primary btn-sm me-2" onclick="previewVideo(${
                  lesson.id
                }, ${courseId})">
                  <i class="fas fa-play me-1"></i>
                  Xem trước
                </button>
                <button class="btn btn-outline-danger btn-sm" onclick="deleteLesson(${
                  lesson.id
                }, ${courseId})">
                  <i class="fas fa-trash me-1"></i>
                  Xóa
                </button>
              </div>
            </div>
          </div>
        </div>
      `
        )
        .join("");
    }

    showModal("lessonsModal");
  } catch (err) {
    console.error("Error in viewLessons:", err);
    showToast("❌ Lỗi khi tải danh sách bài học: " + err.message, "danger");
  }
}

// Delete lesson
async function deleteLesson(lessonId, courseId) {
  if (!confirm("Bạn có chắc muốn xóa bài học này?")) return;

  try {
    await api(`/lessons/${lessonId}`, { method: "DELETE" });
    showToast("✅ Đã xóa bài học thành công!", "success");
    viewLessons(courseId); // Reload lessons list
  } catch (err) {
    showToast("❌ Lỗi khi xóa bài học: " + err.message, "danger");
  }
}

// Edit course
async function editCourse(courseId) {
  try {
    console.log("Edit course called with courseId:", courseId, typeof courseId);

    // Validate courseId
    if (!courseId) {
      showToast("❌ ID khóa học không hợp lệ!", "danger");
      return;
    }

    // Load course details
    const courses = await api("/courses?mine=true");
    console.log("Loaded courses:", courses);

    const course = courses.find((c) => c.id == courseId);
    console.log("Found course:", course);

    if (!course) {
      showToast("❌ Không tìm thấy khóa học!", "danger");
      return;
    }

    // Populate form with course data
    const form = document.getElementById("editCourseForm");
    if (!form) {
      showToast("❌ Không tìm thấy form chỉnh sửa!", "danger");
      return;
    }

    form.courseId.value = courseId;
    form.title.value = course.title || "";
    form.description.value = course.description || "";
    form.priceCents.value = course.priceCents || 0;
    form.currency.value = course.currency || "VND";
    form.thumbnailUrl.value = course.thumbnailUrl || "";

    showModal("editCourseModal");
  } catch (err) {
    console.error("Error in editCourse:", err);
    showToast("❌ Lỗi khi tải thông tin khóa học: " + err.message, "danger");
  }
}

// Submit edit course form
async function submitEditCourse() {
  const form = document.getElementById("editCourseForm");
  const formData = new FormData(form);
  const courseId = formData.get("courseId");
  const data = Object.fromEntries(formData.entries());

  // Remove courseId from data
  delete data.courseId;

  try {
    await api(`/courses/${courseId}`, {
      method: "PUT",
      body: data,
    });
    hideModal("editCourseModal");
    showToast("✅ Cập nhật khóa học thành công!", "success");
    form.reset();
    loadCourses();
  } catch (err) {
    showToast("❌ Lỗi khi cập nhật khóa học: " + err.message, "danger");
  }
}

// Logout
function logout() {
  localStorage.removeItem(TOKEN_KEY);
  showToast("👋 Đang đăng xuất...", "info");
  setTimeout(() => {
    window.location.href = "/auth.html";
  }, 1000);
}

// Check payment status (if redirected from payment)
function checkPaymentStatus() {
  const params = new URLSearchParams(window.location.search);
  const paymentStatus = params.get("payment");

  if (paymentStatus === "success") {
    showToast("✅ Thanh toán thành công! Khóa học đã được đăng ký.", "success");
    // Xóa query parameter
    setTimeout(() => {
      const url = new URL(window.location);
      url.searchParams.delete("payment");
      window.history.replaceState({}, "", url);
    }, 2000);
  } else if (paymentStatus === "failed") {
    showToast("❌ Thanh toán thất bại! Vui lòng thử lại.", "danger");
    // Xóa query parameter
    setTimeout(() => {
      const url = new URL(window.location);
      url.searchParams.delete("payment");
      window.history.replaceState({}, "", url);
    }, 2000);
  }
}

// Load courses on page load
document.addEventListener("DOMContentLoaded", () => {
  if (!getToken()) {
    window.location.href = "/auth.html";
    return;
  }
  checkPaymentStatus();
  loadCourses();
});
