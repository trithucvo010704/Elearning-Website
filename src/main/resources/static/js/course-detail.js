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

    // Check enrollment status
    await checkEnrollmentStatus(courseId, isFree);

    // Load lessons
    await loadLessons(courseId);
  } catch (err) {
    console.error("Error loading course:", err);
  }
}

// ===== Check Enrollment Status =====
async function checkEnrollmentStatus(courseId, isFree) {
  const token = getToken();
  
  // Nếu khóa học miễn phí, không cần check enrollment
  if (isFree) {
    $("#btnEnroll").classList.add("d-none");
    $("#enrolledBadge").classList.add("d-none");
    return;
  }

  // Nếu chưa đăng nhập, hiển thị nút đăng ký
  if (!token) {
    $("#btnEnroll").classList.remove("d-none");
    $("#enrolledBadge").classList.add("d-none");
    return;
  }

  try {
    // Gọi API kiểm tra enrollment status
    const response = await api(`/api/courses/${courseId}/enrollment-status`, { auth: true });
    
    if (response.enrolled) {
      // Đã đăng ký - ẩn nút đăng ký, hiển thị badge
      $("#btnEnroll").classList.add("d-none");
      $("#enrolledBadge").classList.remove("d-none");
    } else {
      // Chưa đăng ký - hiển thị nút đăng ký
      $("#btnEnroll").classList.remove("d-none");
      $("#enrolledBadge").classList.add("d-none");
    }
  } catch (err) {
    console.error("Error checking enrollment status:", err);
    // Nếu có lỗi, hiển thị nút đăng ký
    $("#btnEnroll").classList.remove("d-none");
    $("#enrolledBadge").classList.add("d-none");
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
async function enrollCourse() {
  const token = getToken();
  if (!token) {
    const goLogin = confirm("Bạn cần đăng nhập để đăng ký khóa học. Đăng nhập ngay?");
    if (goLogin) {
      window.location.href = "/auth.html#/login";
    }
    return;
  }

  const courseId = getCourseId();
  if (!courseId) {
    alert("Không xác định được khóa học.");
    return;
  }

  try {
    const res = await fetch(`${window.API_BASE}/api/payment/vnpay/course/${courseId}/checkout`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    });

    if (!res.ok) {
      if (res.status === 400) {
        const text = await res.text();
        alert(text || "Không thể tạo thanh toán.");
      } else if (res.status === 401) {
        alert("Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.");
        window.location.href = "/auth.html#/login";
      } else {
        alert(`Lỗi tạo thanh toán: HTTP ${res.status}`);
      }
      return;
    }

    const data = await res.json();
    const paymentUrl = data.url;
    if (!paymentUrl) {
      alert("Không nhận được URL thanh toán từ server.");
      return;
    }

    // Redirect sang VNPay
    window.location.href = paymentUrl;
  } catch (err) {
    console.error("Error while creating payment:", err);
    alert("Có lỗi xảy ra khi tạo thanh toán. Vui lòng thử lại sau.");
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

// ===== Check Payment Status =====
function checkPaymentStatus() {
  const params = new URLSearchParams(window.location.search);
  const paymentStatus = params.get("payment");

  if (paymentStatus === "success") {
    // Hiển thị thông báo thanh toán thành công
    showSuccessMessage("Thanh toán thành công! Bạn đã đăng ký khóa học này. Trang sẽ tự động tải lại...");
    
    // Xóa query parameter và reload trang sau 2 giây
    setTimeout(() => {
      const url = new URL(window.location);
      url.searchParams.delete("payment");
      window.history.replaceState({}, "", url);
      window.location.reload();
    }, 2000);
  } else if (paymentStatus === "failed") {
    // Hiển thị thông báo thanh toán thất bại
    showErrorMessage("Thanh toán thất bại! Vui lòng thử lại.");
    
    // Xóa query parameter
    setTimeout(() => {
      const url = new URL(window.location);
      url.searchParams.delete("payment");
      window.history.replaceState({}, "", url);
    }, 3000);
  }
}

// ===== Show Success Message =====
function showSuccessMessage(message) {
  const alertDiv = document.createElement("div");
  alertDiv.className = "alert alert-success alert-dismissible fade show position-fixed top-0 start-50 translate-middle-x mt-3";
  alertDiv.style.zIndex = "9999";
  alertDiv.innerHTML = `
    <i class="bi bi-check-circle-fill me-2"></i>
    ${message}
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  `;
  document.body.appendChild(alertDiv);

  // Tự động xóa sau 5 giây
  setTimeout(() => {
    alertDiv.remove();
  }, 5000);
}

// ===== Show Error Message =====
function showErrorMessage(message) {
  const alertDiv = document.createElement("div");
  alertDiv.className = "alert alert-danger alert-dismissible fade show position-fixed top-0 start-50 translate-middle-x mt-3";
  alertDiv.style.zIndex = "9999";
  alertDiv.innerHTML = `
    <i class="bi bi-exclamation-triangle-fill me-2"></i>
    ${message}
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  `;
  document.body.appendChild(alertDiv);

  // Tự động xóa sau 5 giây
  setTimeout(() => {
    alertDiv.remove();
  }, 5000);
}

// ===== Boot =====
document.addEventListener("DOMContentLoaded", () => {
  checkAuth();
  checkPaymentStatus();
  loadCourseDetails();

  const btnEnroll = $("#btnEnroll");
  if (btnEnroll) {
    btnEnroll.addEventListener("click", enrollCourse);
  }

});
