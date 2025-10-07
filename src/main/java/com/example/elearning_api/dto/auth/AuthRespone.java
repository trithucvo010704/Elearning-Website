package com.example.elearning_api.dto.auth;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
public class AuthRespone {
    private String token;
    private UserDto user;

    public AuthRespone() {
    }

    public AuthRespone(String token, UserDto user) {
        this.token = token;
        this.user = user;
    }

    @Getter
    @AllArgsConstructor
    public static class UserDto {
        private Long id;
        private String username;
        private String fullName;
        private String role;
    }
}
