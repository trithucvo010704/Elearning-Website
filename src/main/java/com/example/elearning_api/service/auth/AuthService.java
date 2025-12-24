package com.example.elearning_api.service.auth;

import com.example.elearning_api.Enum.Role;
import com.example.elearning_api.dto.auth.AuthRequest;
import com.example.elearning_api.dto.auth.AuthResponse;
import com.example.elearning_api.dto.auth.RegisterRequest;
import com.example.elearning_api.entity.User;
import com.example.elearning_api.repository.UserRepository;
import com.example.elearning_api.security.JwtService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AuthService {
    private final UserRepository users;
    private final PasswordEncoder encoder;
    private final JwtService jwt;

    public AuthResponse register(RegisterRequest req) {
        String username = req.getUsername().trim();

        if (users.existsByUsername(username)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Username already exists");
        }
        User u = new User();
        u.setUsername(username);
        u.setPasswordHash(encoder.encode(req.getPassword()));
        u.setFullName(Optional.ofNullable(req.getFullName()).orElse(username));
        // Nếu bạn muốn chọn role khi đăng ký, thêm field vào RegisterRequest.
        u.setRole(Role.STUDENT); // mặc định STUDENT
        u.setEnabled(true);

        users.save(u);

        // Null-safe: Handle null role when generating token
        String roleName = (u.getRole() != null) ? u.getRole().name() : "STUDENT";
        String token = jwt.generateToken(
                u.getUsername(),
                Map.of("uid", u.getId(), "role", roleName));

        return new AuthResponse(token, toDto(u));
    }

    public AuthResponse login(AuthRequest req) {
        try {
            System.out.println("=== LOGIN START ===");
            System.out.println("Username: " + req.getUsername());

            User u = users.findByUsername(req.getUsername())
                    .orElseThrow(() -> new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Invalid credentials"));

            System.out.println("User found: " + u.getUsername());
            System.out.println("User enabled: " + u.isEnabled());
            System.out.println("User role: " + u.getRole());
            System.out.println("User fullName: " + u.getFullName());
            System.out.println("Password hash in DB: " + u.getPassword());

            if (!u.isEnabled()) {
                System.out.println("User is disabled!");
                throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "User is disabled");
            }

            System.out.println("Comparing passwords...");
            System.out.println("Input password: " + req.getPassword());
            System.out.println("Hash from DB: " + u.getPassword());

            boolean passwordMatch = encoder.matches(req.getPassword(), u.getPassword());
            System.out.println("Password match result: " + passwordMatch);

            if (!passwordMatch) {
                System.out.println("Password mismatch!");
                throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Invalid password");
            }

            System.out.println("✅ Password matched!");

            // Null-safe: Handle null role when generating token
            String roleName = (u.getRole() != null) ? u.getRole().name() : "STUDENT";
            System.out.println("Generating token with role: " + roleName);

            String token = jwt.generateToken(
                    u.getUsername(),
                    Map.of("uid", u.getId(), "role", roleName));

            System.out.println("Token generated successfully");
            System.out.println("=== LOGIN SUCCESS ===");

            return new AuthResponse(token, toDto(u));
        } catch (Exception e) {
            System.err.println("=== LOGIN ERROR ===");
            System.err.println("Error: " + e.getClass().getName());
            System.err.println("Message: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    public AuthResponse me(String username) {
        User u = users.findByUsername(username)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));
        // /me không cấp token mới
        return new AuthResponse(null, toDto(u));
    }

    private AuthResponse.UserDto toDto(User u) {
        // Null-safe: Handle null role and fullName
        String roleName = (u.getRole() != null) ? u.getRole().name() : "STUDENT";
        String fullName = (u.getFullName() != null) ? u.getFullName() : u.getUsername();
        return new AuthResponse.UserDto(u.getId(), u.getUsername(), fullName, roleName);
    }

    // TEMPORARY: For generating password hash
    public String generatePasswordHash(String password) {
        return encoder.encode(password);
    }

    // EMERGENCY: Reset all passwords
    public void resetAllPasswords(String newPassword) {
        String hash = encoder.encode(newPassword);
        List<String> usernames = List.of("admin", "instructor_demo", "student_demo");
        for (String username : usernames) {
            users.findByUsername(username).ifPresent(u -> {
                u.setPasswordHash(hash);
                users.save(u);
                System.out.println("Reset password for: " + username);
            });
        }
    }
}
