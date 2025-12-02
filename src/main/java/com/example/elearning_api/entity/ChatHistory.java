package com.example.elearning_api.entity;

import com.example.elearning_api.Enum.MessageRole;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

/**
 * Entity lưu trữ lịch sử chat giữa học viên và AI
 * Hỗ trợ tính năng chatbot hỏi đáp trong từng khóa học
 * 
 * @author phongdh
 * @version 1.0
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

    /**
     * Người dùng tham gia chat
     * Liên kết đến bảng users
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
     * Chat được phân loại theo từng khóa học
     */
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(
            name = "course_id",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_chat_course")
    )
    private Course course;

    /**
     * Vai trò của tin nhắn: USER hoặc AI
     * Phân biệt tin nhắn từ người dùng và phản hồi từ AI
     */
    @Enumerated(EnumType.STRING)
    @Column(name = "message_role", nullable = false, length = 8)
    private MessageRole messageRole;

    /**
     * Nội dung tin nhắn
     * Có thể chứa văn bản dài nên sử dụng @Lob
     */
    @Lob
    @Column(nullable = false)
    private String content;

}
