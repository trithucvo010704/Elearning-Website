package com.example.elearning_api.service;

import com.example.elearning_api.Enum.CourseStatus;
import com.example.elearning_api.entity.Course;
import com.example.elearning_api.repository.CourseRepository;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class ChatService {

    private final CourseRepository courseRepository;
    private final ObjectMapper objectMapper;

    // Cấu hình Ollama (Local AI)
    private static final String OLLAMA_URL = "http://localhost:11434/api/chat";
    private static final String OLLAMA_MODEL = "qwen2.5:0.5b"; // Model nhẹ, nhanh cho máy cá nhân

    public String getChatResponse(String userMessage) {
        try {
            // 1. Lấy dữ liệu khóa học để làm context
            List<Course> courses = courseRepository.findAllByStatusAndDeletedAtIsNull(CourseStatus.PUBLISHED);
            String courseData = courses.stream()
                    .map(c -> String.format("- Tên: %s | Giá: %s %s | ID: %d | Link: /course.html?id=%d",
                            c.getTitle(),
                            c.getPriceCents() == 0 ? "Miễn phí" : c.getPriceCents(),
                            c.getCurrency(),
                            c.getId(),
                            c.getId()))
                    .collect(Collectors.joining("\n"));

            // 2. Tạo System Prompt
            String systemPrompt = """
                    Vai trò: Bạn là Trợ lý AI chuyên nghiệp của nền tảng "E-Learning Platform".
                    Nhiệm vụ: Tư vấn lộ trình học, giải đáp thắc mắc và CHỐT ĐƠN (gợi ý khóa học phù hợp).

                    DỮ LIỆU KHÓA HỌC HIỆN CÓ:
                    %s

                    NGUYÊN TẮC:
                    1. Nếu khách hỏi kỹ năng, kiểm tra danh sách khóa học để giới thiệu.
                    2. Trả lời ngắn gọn, thân thiện, dùng emoji 🚀.
                    3. Ngôn ngữ: Tiếng Việt.
                    """.formatted(courseData);

            // 3. Tạo Request Body cho Ollama
            ObjectNode rootNode = objectMapper.createObjectNode();
            rootNode.put("model", OLLAMA_MODEL);
            rootNode.put("stream", false); // Tắt stream để nhận JSON 1 lần

            ArrayNode messages = rootNode.putArray("messages");

            // System Message
            ObjectNode systemMsg = messages.addObject();
            systemMsg.put("role", "system");
            systemMsg.put("content", systemPrompt);

            // User Message
            ObjectNode userMsg = messages.addObject();
            userMsg.put("role", "user");
            userMsg.put("content", userMessage);

            String requestBody = objectMapper.writeValueAsString(rootNode);

            // 4. Gọi API Ollama
            HttpClient client = HttpClient.newBuilder()
                    .connectTimeout(Duration.ofSeconds(5))
                    .build();
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(OLLAMA_URL))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(requestBody, StandardCharsets.UTF_8))
                    .build();

            log.info("Calling Ollama chat API");
            HttpResponse<String> response = client.sendAsync(request, HttpResponse.BodyHandlers.ofString())
                    .orTimeout(20, TimeUnit.SECONDS)
                    .join();
            log.info("Ollama responded with status {}", response.statusCode());

            if (response.statusCode() == 200) {
                JsonNode responseNode = objectMapper.readTree(response.body());
                // Ollama trả về: { "message": { "content": "..." } }
                return responseNode.path("message").path("content").asText();
            } else {
                log.error("Ollama Error: {} - {}", response.statusCode(), response.body());
                return "Xin lỗi, mình đang gặp sự cố kết nối với AI Local. Bạn đã bật Ollama chưa?";
            }

        } catch (Exception e) {
            log.error("Chat Error", e);
            return "Xin lỗi, server đang bận. Vui lòng thử lại sau.";
        }
    }
}
