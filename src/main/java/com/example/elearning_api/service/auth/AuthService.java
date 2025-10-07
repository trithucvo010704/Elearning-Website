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
        User u = new User();
        u.setUsername(username);
        u.setPasswordHash(encoder.encode(req.getPassword()));
        u.setFullName(Optional.ofNullable(req.getFullName()).orElse(username));
        // Nếu bạn muốn chọn role khi đăng ký, thêm field vào RegisterRequest.
        u.setRole(Role.STUDENT);    // mặc định STUDENT
        u.setEnabled(true);

        users.save(u);

        String token = jwt.generateToken(
                u.getUsername(),
                Map.of("uid", u.getId(), "role", u.getRole().name())
        );

        return new AuthRespone(token, toDto(u));
    }

    public AuthRespone login(AuthRequest req) {
        User u = users.findByUsername(req.getUsername())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Invalid credentials"));

        if (!u.isEnabled() || !encoder.matches(req.getPassword(), u.getPassword())) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Invalid credentials");
        }

        String token = jwt.generateToken(
                u.getUsername(),
                Map.of("uid", u.getId(), "role", u.getRole().name())
        );

        return new AuthRespone(token, toDto(u));
    }

    public AuthRespone me(String username) {
        User u = users.findByUsername(username)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));
        // /me không cấp token mới
        return new AuthRespone(null, toDto(u));
    }

    private AuthRespone.UserDto toDto(User u) {
        return new AuthRespone.UserDto(u.getId(), u.getUsername(), u.getFullName(), u.getRole().name());
    }

}
