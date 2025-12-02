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

/**
 * Cấu hình bảo mật toàn diện cho ứng dụng E-Learning Platform
 * 
 * <p>Kiến trúc bảo mật:</p>
 * <ul>
 *   <li>Stateless Authentication - Sử dụng JWT Token</li>
 *   <li>BCrypt Password Hashing - Mã hóa mật khẩu an toàn</li>
 *   <li>Role-based Access Control (RBAC) - Phân quyền theo vai trò</li>
 *   <li>Method-level Security - Bảo vệ ở mức method với @PreAuthorize</li>
 * </ul>
 * 
 * <p>Security Flow:</p>
 * <ol>
 *   <li>Request đến server</li>
 *   <li>JwtAuthenticationFilter kiểm tra token trong header</li>
 *   <li>Nếu token hợp lệ, set Authentication vào SecurityContext</li>
 *   <li>AuthorizationFilter kiểm tra quyền truy cập endpoint</li>
 *   <li>Nếu đủ quyền, request được xử lý bởi Controller</li>
 * </ol>
 * 
 * @author phongdh
 * @version 1.1
 * @since 2024-12-02
 * @see JwtAuthenticationFilter
 * @see BCryptPasswordEncoder
 */
@Configuration
@EnableMethodSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    // ==================== DEPENDENCIES ====================

    /**
     * JWT Authentication Filter - Xử lý token trong mỗi request
     * Được inject tự động bởi Spring
     */
    private final JwtAuthenticationFilter jwtFilter;

    /**
     * UserDetailsService - Load thông tin user từ database
     * Implementation: AuthUserDetailsService
     */
    private final UserDetailsService uds;

    // ==================== PASSWORD ENCODER ====================

    /**
     * Bean mã hóa mật khẩu sử dụng BCrypt Algorithm
     * 
     * <p>Đặc điểm của BCrypt:</p>
     * <ul>
     *   <li>Tự động generate salt cho mỗi password</li>
     *   <li>Có work factor có thể điều chỉnh (default: 10)</li>
     *   <li>Chống rainbow table attacks</li>
     *   <li>Slow hashing - chống brute force</li>
     * </ul>
     * 
     * @return PasswordEncoder instance sử dụng BCrypt
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // ==================== AUTHENTICATION PROVIDER ====================

    /**
     * Cấu hình Authentication Provider sử dụng DAO pattern
     * Kết hợp UserDetailsService và PasswordEncoder để xác thực
     * 
     * @return DaoAuthenticationProvider đã được cấu hình đầy đủ
     */
    @Bean
    public DaoAuthenticationProvider authProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setPasswordEncoder(passwordEncoder());
        authProvider.setUserDetailsService(uds);
        return authProvider;
    }

    // ==================== SECURITY FILTER CHAIN ====================

    /**
     * Cấu hình Security Filter Chain - Định nghĩa các rule bảo mật
     * 
     * <p>Public Endpoints (Không cần xác thực):</p>
     * <ul>
     *   <li>Static pages: /, /index.html, /auth.html</li>
     *   <li>Static resources: /css/**, /js/**, /favicon.ico</li>
     *   <li>Health check: GET /actuator/health</li>
     *   <li>Auth endpoints: /api/auth/register, /api/auth/login</li>
     * </ul>
     * 
     * <p>Protected Endpoints:</p>
     * <ul>
     *   <li>Tất cả endpoints khác yêu cầu JWT token hợp lệ</li>
     *   <li>Role-specific endpoints được kiểm tra thêm ở Controller</li>
     * </ul>
     * 
     * @param http HttpSecurity builder để cấu hình
     * @return SecurityFilterChain đã được build
     * @throws Exception nếu có lỗi trong quá trình cấu hình
     */
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                // [1] Tắt CSRF - Không cần thiết cho stateless JWT authentication
                .csrf(csrf -> csrf.disable())

                // [2] Cấu hình Stateless Session - Không tạo HTTP session
                .sessionManagement(session -> 
                        session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )

                // [3] Xử lý Exception cho Authentication và Authorization
                .exceptionHandling(exception -> exception
                        // 401 Unauthorized - Khi không có token hoặc token không hợp lệ
                        .authenticationEntryPoint((request, response, authException) -> 
                                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized")
                        )
                        // 403 Forbidden - Khi không đủ quyền truy cập
                        .accessDeniedHandler((request, response, accessDeniedException) -> 
                                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied")
                        )
                )

                // [4] Cấu hình Authorization Rules cho các endpoints
                .authorizeHttpRequests(authorize -> authorize
                        // Public: Static pages
                        .requestMatchers("/", "/index.html", "/auth.html").permitAll()
                        // Public: Static resources (CSS, JS, images)
                        .requestMatchers("/css/**", "/js/**", "/favicon.ico").permitAll()
                        // Public: Health check endpoint cho monitoring
                        .requestMatchers(HttpMethod.GET, "/actuator/health").permitAll()
                        // Public: Authentication endpoints - CHỈ register và login
                        .requestMatchers("/api/auth/register", "/api/auth/login").permitAll()
                        // Protected: Tất cả request khác yêu cầu authentication
                        .anyRequest().authenticated()
                )

                // [5] Đăng ký Authentication Provider
                .authenticationProvider(authProvider())

                // [6] Thêm JWT Filter vào filter chain (trước UsernamePasswordAuthenticationFilter)
                .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    // ==================== AUTHENTICATION MANAGER ====================

    /**
     * Bean AuthenticationManager để xử lý authentication requests
     * Được sử dụng trong các service cần xác thực thủ công
     * 
     * @param config AuthenticationConfiguration từ Spring Security
     * @return AuthenticationManager instance
     * @throws Exception nếu có lỗi khi lấy AuthenticationManager
     */
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }

}
