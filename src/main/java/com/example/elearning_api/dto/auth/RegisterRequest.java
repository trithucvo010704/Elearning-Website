package com.example.elearning_api.dto.auth;

import lombok.AllArgsConstructor;
import lombok.Data;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RegisterRequest {
    @NotBlank
    @Size(min = 3, max = 64)
    private String username;
    
    @NotBlank
    @Size(min = 6, max = 72)
    private String password;

    private String fullName; // optional
}

