package com.example.elearning_api.config;

import com.example.elearning_api.security.JwtAuthenticationFilter;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableMethodSecurity
@RequiredArgsConstructor
public class SecurityConfig {
    private final JwtAuthenticationFilter jwtFilter;// Field: Filter tùy chỉnh để kiểm tra JWT token trong request.
    private final UserDetailsService uds; // Field: Service để load chi tiết user từ database (implement
                                          // UserDetailsService).

    @Bean // Trả về BCryptPasswordEncoder, một thuật toán mã hóa mật khẩu an toàn (hash +
          // salt).
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean // dùng để xác thực user từ database.
    DaoAuthenticationProvider authProvider() {
        var dap = new DaoAuthenticationProvider();// Tạo instance của DaoAuthenticationProvider.
        dap.setPasswordEncoder(passwordEncoder()); // Set encoder để so sánh mật khẩu (sử dụng bean passwordEncoder ở
                                                   // trên).
        dap.setUserDetailsService(uds);// Set service để load user (uds là UserDetailsService inject qua constructor).
        return dap;
    }

    @Bean // Bean chính: SecurityFilterChain, định nghĩa toàn bộ chuỗi filter bảo mật.
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.csrf(csrf -> csrf.disable()) // Tắt CSRF vì ứng dụng stateless (JWT), không cần token CSRF.
                .sessionManagement(sm -> sm.sessionCreationPolicy(SessionCreationPolicy.STATELESS)) // Set policy
                                                                                                    // session là
                                                                                                    // stateless: Không
                                                                                                    // tạo session, dùng
                                                                                                    // JWT thay thế.
                // Quan trọng: trả 401 khi thiếu token, 403 khi thiếu quyền
                .exceptionHandling(ex -> ex
                        .authenticationEntryPoint((req, res, e) -> res.sendError(HttpServletResponse.SC_UNAUTHORIZED))
                        .accessDeniedHandler((req, res, e) -> res.sendError(HttpServletResponse.SC_FORBIDDEN)))
                .authorizeHttpRequests(auth -> auth
                        // Static pages - ALL PUBLIC (protection via JavaScript guards)
                        .requestMatchers("/", "/index.html",
                                "/auth.html", "/course.html", "/admin.html", "/api/auth/**",
                                "/api/payment/vnpay/return",
                                "/api/payment/vnpay/ipn",
                                "/courses.html")
                        .permitAll()
                        .requestMatchers("/css/**", "/js/**", "/favicon.ico").permitAll()
                        .requestMatchers(HttpMethod.GET, "/actuator/health").permitAll()
                        // Auth endpoints - Public
                        .requestMatchers("/api/auth/register", "/api/auth/login").permitAll()
                        .requestMatchers("/api/auth/hash/**").permitAll()
                        // Public APIs - Không cần authentication
                        .requestMatchers(HttpMethod.GET, "/api/courses", "/api/courses/**").permitAll()
                        // Chat API - Public
                        .requestMatchers("/api/chat/**").permitAll()
                        // All other requests require authentication
                        .anyRequest().authenticated())
                .authenticationProvider(authProvider())
                .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class);// Thêm filter JWT trước filter
                                                                                        // mặc định của Spring để kiểm
                                                                                        // tra token sớm.
        return http.build();
    }

    @Bean
    AuthenticationManager authenticationManager(AuthenticationConfiguration cfg) throws Exception {
        return cfg.getAuthenticationManager();
    }
}
