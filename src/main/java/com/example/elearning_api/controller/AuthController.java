package com.example.elearning_api.controller;

import com.example.elearning_api.dto.auth.AuthRequest;
import com.example.elearning_api.dto.auth.AuthResponse;
import com.example.elearning_api.dto.auth.RegisterRequest;
import com.example.elearning_api.service.auth.AuthService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {
    private final AuthService auth;

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody @Valid RegisterRequest req) {
        return ResponseEntity.ok(auth.register(req));
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody @Valid AuthRequest req) {
        return ResponseEntity.ok(auth.login(req));
    }

    @GetMapping("/me")
    public ResponseEntity<AuthResponse> me(Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated())
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Not authenticated");
        String username = authentication.getName();
        return ResponseEntity.ok(auth.me(username));
    }

    // TEMPORARY: Generate BCrypt hash for testing
    @GetMapping("/hash/{password}")
    public ResponseEntity<?> generateHash(@PathVariable String password) {
        String hash = auth.generatePasswordHash(password);
        return ResponseEntity.ok(java.util.Map.of(
                "password", password,
                "hash", hash,
                "sql", "UPDATE users SET password_hash = '" + hash + "' WHERE username = 'admin';"));
    }
}
