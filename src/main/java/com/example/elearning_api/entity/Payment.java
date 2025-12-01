package com.example.elearning_api.entity;

import com.example.elearning_api.Enum.PaymentStatus;
import com.example.elearning_api.Enum.Provider;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(
        name = "payments",
        indexes = {
                @Index(name = "idx_pay_user_course", columnList = "user_id, course_id"),
                @Index(name = "idx_pay_status_created", columnList = "status, created_at"),
                @Index(name = "idx_pay_order_created", columnList = "order_id, created_at")
        }
)
public class Payment extends BaseEntity {

        // ===================== RELATIONS =====================

        @ManyToOne(fetch = FetchType.LAZY, optional = false)
        @JoinColumn(
                name = "user_id",
                nullable = false,
                foreignKey = @ForeignKey(name = "fk_pay_user")
        )
        private User user;

        @ManyToOne(fetch = FetchType.LAZY, optional = false)
        @JoinColumn(
                name = "course_id",
                nullable = false,
                foreignKey = @ForeignKey(name = "fk_pay_course")
        )
        private Course course;

        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(
                name = "enrollment_id",
                foreignKey = @ForeignKey(name = "fk_pay_enrollment")
        )
        private Enrollment enrollment;

        @ManyToOne(fetch = FetchType.LAZY)
        @JoinColumn(
                name = "order_id",
                foreignKey = @ForeignKey(name = "fk_pay_order")
        )
        private Order order;

        // ===================== STRIPE FIELDS =====================

        @Column(name = "stripe_session_id", unique = true)
        private String stripeSessionId;

        @Column(name = "stripe_payment_intent", unique = true)
        private String stripePaymentIntent;

        @Column(name = "stripe_event_id", unique = true)
        private String stripeEventId;

        // ===================== COMMON PAYMENT FIELDS =====================

        @Column(name = "amount_cents", nullable = false)
        private Long amountCents = 0L;

        public long getAmount() {
                return amountCents;
        }

        @Column(nullable = false, length = 10)
        private String currency = "USD";

        @Enumerated(EnumType.STRING)
        @Column(nullable = false, length = 16)
        private Provider provider = Provider.STRIPE;

        @Column(length = 64)
        private String method;

        @Column(name = "refunded_amount_cents", nullable = false)
        private Integer refundedAmountCents = 0;

        @Enumerated(EnumType.STRING)
        @Column(nullable = false, length = 16)
        private PaymentStatus status;

        // ===================== VNPAY FIELDS =====================

        /**
         * vnp_TxnRef - mã tham chiếu đơn hàng bên phía merchant
         */
        @Column(name = "vnp_txn_ref", length = 64)
        private String vnpTxnRef;

        /**
         * vnp_TransactionNo - mã giao dịch VNPAY (trả về trong callback)
         */
        @Column(name = "vnp_transaction_no", length = 64)
        private String vnpTransactionNo;

        /**
         * vnp_ResponseCode - mã kết quả giao dịch (00 = thành công)
         */
        @Column(name = "vnp_response_code", length = 16)
        private String vnpResponseCode;

        /**
         * vnp_BankCode - mã ngân hàng thanh toán
         */
        @Column(name = "vnp_bank_code", length = 32)
        private String vnpBankCode;

        /**
         * vnp_SecureHash - chữ ký VNPAY (nếu muốn lưu lại raw)
         */
        @Column(name = "vnp_secure_hash", length = 256)
        private String vnpSecureHash;
}
