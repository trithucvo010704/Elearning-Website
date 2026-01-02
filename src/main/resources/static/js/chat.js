document.addEventListener("DOMContentLoaded", function () {
  // Inject HTML
  const chatHTML = `
        <div class="chat-widget-btn" id="chatBtn">
            <i class="bi bi-chat-dots-fill"></i>
        </div>

        <div class="chat-window" id="chatWindow">
            <div class="chat-header">
                <div class="d-flex align-items-center gap-2">
                    <i class="bi bi-robot"></i>
                    <div>
                        <h5>Trợ lý ảo E-Learning</h5>
                        <small style="font-size: 11px; opacity: 0.8">Luôn sẵn sàng hỗ trợ 24/7</small>
                    </div>
                </div>
                <button class="chat-close-btn" id="chatCloseBtn"><i class="bi bi-x-lg"></i></button>
            </div>
            <div class="chat-body" id="chatBody">
                <div class="message bot">
                    Xin chào! 👋 Mình là trợ lý ảo của E-Learning Platform.<br>
                    Mình có thể giúp gì cho bạn hôm nay?
                </div>
                <div class="chat-chips">
                    <span class="chat-chip" onclick="sendChip('Lộ trình cho người mới')">🌱 Lộ trình cho người mới</span>
                    <span class="chat-chip" onclick="sendChip('Khóa học lập trình Web')">💻 Khóa học lập trình Web</span>
                    <span class="chat-chip" onclick="sendChip('Các khóa học miễn phí')">💰 Các khóa học miễn phí</span>
                </div>
            </div>
            <div class="chat-footer">
                <input type="text" id="chatInput" placeholder="Nhập câu hỏi của bạn...">
                <button id="chatSendBtn"><i class="bi bi-send-fill"></i></button>
            </div>
        </div>
    `;
  document.body.insertAdjacentHTML("beforeend", chatHTML);

  // Elements
  const chatBtn = document.getElementById("chatBtn");
  const chatWindow = document.getElementById("chatWindow");
  const chatCloseBtn = document.getElementById("chatCloseBtn");
  const chatInput = document.getElementById("chatInput");
  const chatSendBtn = document.getElementById("chatSendBtn");
  const chatBody = document.getElementById("chatBody");

  // Toggle Chat
  chatBtn.addEventListener("click", () => {
    chatWindow.classList.add("active");
    chatBtn.style.transform = "scale(0)";
  });

  chatCloseBtn.addEventListener("click", () => {
    chatWindow.classList.remove("active");
    chatBtn.style.transform = "scale(1)";
  });

  // Send Message Logic
  async function sendMessage(message) {
    if (!message) return;

    // Add User Message
    addMessage(message, "user");
    chatInput.value = "";

    // Add Loading
    const loadingId = addLoading();
    scrollToBottom();

    try {
      const response = await fetch("/api/chat/ask", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ message: message }),
      });

      const data = await response.json();

      // Remove Loading
      removeLoading(loadingId);

      // Add Bot Response
      addMessage(data.reply, "bot");
    } catch (error) {
      removeLoading(loadingId);
      addMessage(
        "Xin lỗi, mình đang gặp sự cố kết nối. Vui lòng thử lại sau! 😓",
        "bot"
      );
      console.error("Chat Error:", error);
    }
  }

  // Helper: Add Message to UI
  function addMessage(text, sender) {
    const div = document.createElement("div");
    div.className = `message ${sender}`;
    // Simple Link Parsing
    const parsedText = text
      .replace(
        /(https?:\/\/[^\s]+)/g,
        '<a href="$1" target="_blank" style="color: #667eea; text-decoration: underline;">$1</a>'
      )
      .replace(/\n/g, "<br>");

    div.innerHTML = parsedText;
    chatBody.appendChild(div);
    scrollToBottom();
  }

  // Helper: Add Loading Indicator
  function addLoading() {
    const id = "loading-" + Date.now();
    const div = document.createElement("div");
    div.className = "message bot";
    div.id = id;
    div.innerHTML = `
            <div class="typing-indicator">
                <div class="typing-dot"></div>
                <div class="typing-dot"></div>
                <div class="typing-dot"></div>
            </div>
        `;
    chatBody.appendChild(div);
    return id;
  }

  function removeLoading(id) {
    const el = document.getElementById(id);
    if (el) el.remove();
  }

  function scrollToBottom() {
    chatBody.scrollTop = chatBody.scrollHeight;
  }

  // Event Listeners
  chatSendBtn.addEventListener("click", () =>
    sendMessage(chatInput.value.trim())
  );
  chatInput.addEventListener("keypress", (e) => {
    if (e.key === "Enter") sendMessage(chatInput.value.trim());
  });

  // Global function for chips
  window.sendChip = function (text) {
    sendMessage(text);
  };
});
