package com.example.elearning_api.service.auth;

import com.example.elearning_api.Enum.Role;
import com.example.elearning_api.dto.auth.AuthRequest;
import com.example.elearning_api.dto.auth.AuthRespone;
import com.example.elearning_api.dto.auth.RegisterRequest;
import com.example.elearning_api.entity.User;
import com.example.elearning_api.repository.UserRepo;
import com.example.elearning_api.security.JwtService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.Map;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AuthService {
    private final UserRepo users;
    private final PasswordEncoder encoder;
    private final JwtService jwt;

    public AuthRespone register(RegisterRequest req) {
        String username = req.getUsername().trim();

        if (users.existsByUsername(username)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Username already exists");
        }

        User user = new User();
        user.setUsername(username);
        user.setPasswordHash(encoder.encode(req.getPassword()));
        user.setFullName(Optional.ofNullable(req.getFullName()).orElse(username));
        // Nếu bạn muốn chọn role khi đăng ký, thêm field vào RegisterRequest
        user.setRole(Role.STUDENT); // mặc định STUDENT
        user.setEnabled(true);

        users.save(user);

        String token = jwt.generateToken(
                user.getUsername(),
                Map.of("uid", user.getId(), "role", user.getRole().name())
        );

        return new AuthRespone(token, toDto(user));
    }

    public AuthRespone login(AuthRequest req) {
        User user = users.findByUsername(req.getUsername())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Invalid credentials"));

        if (!user.isEnabled() || !encoder.matches(req.getPassword(), user.getPassword())) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Invalid credentials");
        }

        String token = jwt.generateToken(
                user.getUsername(),
                Map.of("uid", user.getId(), "role", user.getRole().name())
        );

        return new AuthRespone(token, toDto(user));
    }

    public AuthRespone me(String username) {
        User user = users.findByUsername(username)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));

        // /me không cấp token mới
        return new AuthRespone(null, toDto(user));
    }

    private AuthRespone.UserDto toDto(User user) {
        return new AuthRespone.UserDto(
                user.getId(),
                user.getUsername(),
                user.getFullName(),
                user.getRole().name()
        );
    }

}
