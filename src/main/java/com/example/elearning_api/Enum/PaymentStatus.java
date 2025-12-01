package com.example.elearning_api.Enum;
// Trạng thái thanh toán (payments.status)

public enum PaymentStatus {
    REQUIRES_PAYMENT, // cần thanh toán
    PAID,             // đã thanh toán
    FAILED,           // thất bại
    REFUNDED,          // hoàn tiền
    PENDING,             //Đang chờ
    SUCCESS
}
