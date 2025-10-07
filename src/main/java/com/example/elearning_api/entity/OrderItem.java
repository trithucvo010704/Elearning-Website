package com.example.elearning_api.entity;

import jakarta.persistence.*;                                          // import JPA
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity                                                               // đánh dấu entity
@Table(                                                               // cấu hình bảng
        name = "order_items",                                               // tên bảng
        uniqueConstraints = { @UniqueConstraint(name = "uq_order_course_once", columnNames = {"order_id","course_id"}) }, // mỗi course chỉ 1 dòng/đơn
        indexes = { @Index(name = "idx_items_order", columnList = "order_id") } // truy vấn theo order
)
public class OrderItem extends BaseEntity {                            // entity kế thừa BaseEntity


    @ManyToOne(fetch = FetchType.LAZY, optional = false)                // nhiều item thuộc 1 order
    @JoinColumn(name = "order_id", nullable = false,                    // map FK order_id
            foreignKey = @ForeignKey(name = "fk_items_order"))                // tên FK
    private Order order;                                                // quan hệ Order

    @ManyToOne(fetch = FetchType.LAZY, optional = false)                // item tham chiếu 1 course
    @JoinColumn(name = "course_id", nullable = false,                   // map FK course_id
            foreignKey = @ForeignKey(name = "fk_items_course"))               // tên FK
    private Course course;                                              // quan hệ Course

    @Column(name = "unit_price_cents", nullable = false)               // đơn giá cent
    private Integer unitPriceCents;                                     // cột unit_price_cents

    @Column(nullable = false)                                           // số lượng
    private Integer quantity = 1;                                       // cột quantity

    @Column(name = "title_snapshot", length = 255)                      // snapshot tiêu đề tại thời điểm mua
    private String titleSnapshot;                                       // cột title_snapshot

}