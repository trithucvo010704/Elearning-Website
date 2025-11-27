package com.example.elearning_api.entity;


import com.example.elearning_api.Enum.OrderStatus;
import jakarta.persistence.*;                                      // import JPA
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity                                                           // đánh dấu entity
@Table(                                                           // cấu hình bảng
        name = "orders",                                                // tên bảng
        indexes = { @Index(name = "idx_orders_user_created", columnList = "user_id, created_at") } // truy vấn theo user/time
)
public class Order extends BaseEntity {                            // entity kế thừa BaseEntity


    @ManyToOne(fetch = FetchType.LAZY, optional = false)            // nhiều order thuộc 1 user
    @JoinColumn(name = "user_id", nullable = false,                 // map FK user_id
            foreignKey = @ForeignKey(name = "fk_orders_user"))            // tên FK rõ
    private User user;                                              // quan hệ User

    @Enumerated(EnumType.STRING)                                    // lưu enum STRING
    @Column(nullable = false, length = 20)                          // cột status bắt buộc
    private OrderStatus status = OrderStatus.PENDING;               // mặc định PENDING

    @Column(name = "total_amount_cents", nullable = false)          // tổng tiền cent
    private Integer totalAmountCents = 0;                           // cột total_amount_cents

    @Column(nullable = false, length = 10)                          // đơn vị tiền
    private String currency = "USD";                                // cột currency

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(
            name = "course_id",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_orders_course")
    )
    private Course course;
}
