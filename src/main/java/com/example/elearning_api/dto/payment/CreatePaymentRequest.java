package com.example.elearning_api.dto.payment; // hoặc package khác tuỳ bạn

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreatePaymentRequest {

    @NotNull
    private Long orderId;   // id của Order đã tạo trước đó

    @NotNull
    @Min(1)
    private Long amount;    // số tiền (VND), ví dụ 199000
}
