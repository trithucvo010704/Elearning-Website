package com.example.elearning_api.entity;

import com.example.elearning_api.Enum.MessageRole;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

/**
 * Entity lưu trữ lịch sử chat giữa học viên và AI Assistant
 * 
 * <p>Chức năng chính:</p>
 * <ul>
 *   <li>Lưu trữ tin nhắn của người dùng và phản hồi từ AI</li>
 *   <li>Phân loại chat theo từng khóa học cụ thể</li>
 *   <li>Hỗ trợ context-aware chatbot cho việc hỏi đáp</li>
 *   <li>Lưu lịch sử để AI có thể tham khảo các tin nhắn trước</li>
 * </ul>
 * 
 * <p>Quan hệ:</p>
 * <ul>
 *   <li>ManyToOne với User - người dùng tham gia chat</li>
 *   <li>ManyToOne với Course - khóa học liên quan</li>
 * </ul>
 * 
 * @author phongdh
 * @version 1.1
 * @since 2024-12-02
 */
@Getter
@Setter
@Entity
@Table(
        name = "chat_histories",
        indexes = {
                @Index(
                        name = "idx_chat_user_course_created",
                        columnList = "user_id, course_id, created_at DESC"
                ),
                @Index(
                        name = "idx_chat_course_created",
                        columnList = "course_id, created_at"
                )
        }
)
public class ChatHistory extends BaseEntity {

    // ==================== RELATIONSHIPS ====================

    /**
     * Người dùng tham gia cuộc hội thoại
     * Liên kết đến bảng users
     * Không thể null - phải có user
     */
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(
            name = "user_id",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_chat_user")
    )
    private User user;

    /**
     * Khóa học liên quan đến cuộc hội thoại
     * Chat được phân loại theo từng khóa học để AI hiểu context
     * Không thể null - phải thuộc một khóa học
     */
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(
            name = "course_id",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_chat_course")
    )
    private Course course;

    // ==================== MESSAGE FIELDS ====================

    /**
     * Vai trò của tin nhắn trong cuộc hội thoại
     * USER: tin nhắn từ người dùng (câu hỏi)
     * AI: tin nhắn từ AI Assistant (câu trả lời)
     */
    @Enumerated(EnumType.STRING)
    @Column(name = "message_role", nullable = false, length = 8)
    private MessageRole messageRole;

    /**
     * Nội dung tin nhắn
     * Có thể chứa văn bản dài nên sử dụng @Lob
     * Hỗ trợ markdown formatting
     */
    @Lob
    @Column(nullable = false)
    private String content;

}
