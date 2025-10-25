package com.example.elearning_api.entity;

// enum nhà cung cấp
import com.example.elearning_api.Enum.PaymentStatus;
import com.example.elearning_api.Enum.Provider;
import jakarta.persistence.*; // import JPA
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity // đánh dấu entity
@Table( // cấu hình bảng
                name = "payments", // tên bảng
                indexes = {
                                @Index(name = "idx_pay_user_course", columnList = "user_id, course_id"), // tìm theo
                                                                                                         // user+course
                                @Index(name = "idx_pay_status_created", columnList = "status, created_at"), // thống kê
                                                                                                            // theo
                                                                                                            // trạng
                                                                                                            // thái
                                @Index(name = "idx_pay_order_created", columnList = "order_id, created_at") // truy vết
                                                                                                            // theo
                                                                                                            // order/time
                })
public class Payment extends BaseEntity { // entity kế thừa BaseEntity

        @ManyToOne(fetch = FetchType.LAZY, optional = false) // thanh toán thuộc user
        @JoinColumn(name = "user_id", nullable = false, // map FK user_id
                        foreignKey = @ForeignKey(name = "fk_pay_user")) // tên FK
        private User user; // quan hệ User

        @ManyToOne(fetch = FetchType.LAZY, optional = false) // thanh toán gắn với course
        @JoinColumn(name = "course_id", nullable = false, // map FK course_id
                        foreignKey = @ForeignKey(name = "fk_pay_course")) // tên FK
        private Course course; // quan hệ Course

        @ManyToOne(fetch = FetchType.LAZY) // có thể null
        @JoinColumn(name = "enrollment_id", foreignKey = @ForeignKey(name = "fk_pay_enrollment")) // map enrollment
        private Enrollment enrollment; // quan hệ Enrollment

        @ManyToOne(fetch = FetchType.LAZY) // có thể null
        @JoinColumn(name = "order_id", foreignKey = @ForeignKey(name = "fk_pay_order")) // map order
        private Order order; // quan hệ Order

        @Column(name = "stripe_session_id", unique = true) // id phiên checkout
        private String stripeSessionId; // cột stripe_session_id

        @Column(name = "stripe_payment_intent", unique = true) // id intent
        private String stripePaymentIntent; // cột stripe_payment_intent

        @Column(name = "stripe_event_id", unique = true) // id sự kiện webhook
        private String stripeEventId; // cột stripe_event_id

        @Column(name = "amount_cents", nullable = false) // số tiền thanh toán (cents)
        private Long amountCents = 0L; // cột amount_cents

        public long getAmount() { // getter cho số tiền
                return amountCents;
        }

        @Column(nullable = false, length = 10) // đơn vị tiền tệ
        private String currency = "USD"; // cột currency

        @Enumerated(EnumType.STRING) // enum STRING
        @Column(nullable = false, length = 16) // cột provider
        private Provider provider = Provider.STRIPE; // mặc định STRIPE

        @Column(length = 64) // phương thức (card, momo…)
        private String method; // cột method

        @Column(name = "refunded_amount_cents", nullable = false) // số tiền đã hoàn
        private Integer refundedAmountCents = 0; // cột refunded_amount_cents

        @Enumerated(EnumType.STRING) // enum STRING
        @Column(nullable = false, length = 16) // cột status
        private PaymentStatus status; // trạng thái thanh toán
}
