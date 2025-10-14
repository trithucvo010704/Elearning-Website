package com.example.elearning_api.entity;
// enum vai trò tin nhắn
import com.example.elearning_api.Enum.MessageRole;
import jakarta.persistence.*;                                                // import JPA
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity                                                                      // đánh dấu entity
@Table(                                                                      // cấu hình bảng
        name = "chat_histories",                                                   // tên bảng
        indexes = {
                @Index(name = "idx_chat_user_course_created", columnList = "user_id, course_id, created_at DESC"), // truy vấn theo user/course/time
                @Index(name = "idx_chat_course_created",      columnList = "course_id, created_at")                // thống kê theo course
        }
)
public class ChatHistory extends BaseEntity {                                 // entity kế thừa BaseEntity


    @ManyToOne(fetch = FetchType.LAZY, optional = false)                        // thuộc user
    @JoinColumn(name = "user_id", nullable = false,                             // map FK user_id
            foreignKey = @ForeignKey(name = "fk_chat_user"))                          // tên FK
    private User user;                                                          // quan hệ User

    @ManyToOne(fetch = FetchType.LAZY, optional = false)                        // gắn với course
    @JoinColumn(name = "course_id", nullable = false,                           // map FK course_id
            foreignKey = @ForeignKey(name = "fk_chat_course"))                        // tên FK
    private Course course;                                                      // quan hệ Course

    @Enumerated(EnumType.STRING)                                                // enum STRING
    @Column(name = "message_role", nullable = false, length = 8)                // cột vai trò
    private MessageRole messageRole;                                            // USER/AI

    @Lob                                                                         // nội dung dài
    @Column(nullable = false)                                                    // bắt buộc
    private String content;                                                      // nội dung tin nhắn

}
