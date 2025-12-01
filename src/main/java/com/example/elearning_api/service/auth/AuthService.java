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
    private final UserRepo userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;

    public AuthRespone register(RegisterRequest request) {
        String username = request.getUsername().trim();

        if (userRepository.existsByUsername(username)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Username already exists");
        }

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPasswordHash(passwordEncoder.encode(request.getPassword()));
        newUser.setFullName(Optional.ofNullable(request.getFullName()).orElse(username));
        // Nếu bạn muốn chọn role khi đăng ký, thêm field vào RegisterRequest
        newUser.setRole(Role.STUDENT); // mặc định STUDENT
        newUser.setEnabled(true);

        userRepository.save(newUser);

        String token = jwtService.generateToken(
                newUser.getUsername(),
                Map.of("uid", newUser.getId(), "role", newUser.getRole().name())
        );

        return new AuthRespone(token, toDto(newUser));
    }

    public AuthRespone login(AuthRequest request) {
        User user = userRepository.findByUsername(request.getUsername())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Invalid credentials"));

        if (!user.isEnabled() || !passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Invalid credentials");
        }

        String token = jwtService.generateToken(
                user.getUsername(),
                Map.of("uid", user.getId(), "role", user.getRole().name())
        );

        return new AuthRespone(token, toDto(user));
    }

    public AuthRespone me(String username) {
        User user = userRepository.findByUsername(username)
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
