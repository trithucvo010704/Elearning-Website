package com.example.elearning_api.Enum;
// Trạng thái đơn hàng (orders.status)
public enum OrderStatus {
    PENDING,           // mới tạo
    REQUIRES_PAYMENT,  // cần thanh toán
    PAID,              // đã thanh toán
    CANCELED,          // đã hủy
    REFUNDED           // đã hoàn tiền
}
