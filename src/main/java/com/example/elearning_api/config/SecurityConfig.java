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
 * Cấu hình bảo mật cho ứng dụng E-Learning
 * Sử dụng JWT Token để xác thực và BCrypt để mã hóa mật khẩu
 * 
 * <p>Các tính năng bảo mật:</p>
 * <ul>
 *   <li>Stateless session - không lưu session trên server</li>
 *   <li>JWT Authentication Filter - xác thực token mỗi request</li>
 *   <li>BCrypt Password Encoding - mã hóa mật khẩu an toàn</li>
 *   <li>Role-based Authorization - phân quyền theo vai trò</li>
 * </ul>
 * 
 * @author phongdh
 * @version 1.0
 */
@Configuration
@EnableMethodSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    /**
     * JWT Authentication Filter để xử lý token trong mỗi request
     */
    private final JwtAuthenticationFilter jwtFilter;

    /**
     * Service để load thông tin user từ database
     */
    private final UserDetailsService uds;

    /**
     * Bean mã hóa mật khẩu sử dụng BCrypt
     * BCrypt tự động thêm salt và có độ phức tạp có thể điều chỉnh
     * 
     * @return PasswordEncoder instance sử dụng BCrypt algorithm
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    /**
     * Cấu hình Authentication Provider sử dụng DAO
     * Kết hợp UserDetailsService và PasswordEncoder để xác thực
     * 
     * @return DaoAuthenticationProvider đã được cấu hình
     */
    @Bean
    public DaoAuthenticationProvider authProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setPasswordEncoder(passwordEncoder());
        authProvider.setUserDetailsService(uds);
        return authProvider;
    }

    /**
     * Cấu hình Security Filter Chain
     * Định nghĩa các rule bảo mật cho từng endpoint
     * 
     * <p>Public endpoints (không cần xác thực):</p>
     * <ul>
     *   <li>GET /, /index.html, /auth.html - Trang tĩnh</li>
     *   <li>GET /css/**, /js/**, /favicon.ico - Static resources</li>
     *   <li>GET /actuator/health - Health check</li>
     *   <li>POST /api/auth/register, /api/auth/login - Đăng ký, đăng nhập</li>
     * </ul>
     * 
     * <p>Protected endpoints: Tất cả các endpoint còn lại yêu cầu JWT token hợp lệ</p>
     * 
     * @param http HttpSecurity object để cấu hình
     * @return SecurityFilterChain đã được cấu hình
     * @throws Exception nếu có lỗi trong quá trình cấu hình
     */
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                // Tắt CSRF vì sử dụng JWT (stateless)
                .csrf(csrf -> csrf.disable())

                // Cấu hình stateless session - không tạo session
                .sessionManagement(session -> 
                        session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )

                // Xử lý exception: 401 Unauthorized, 403 Forbidden
                .exceptionHandling(exception -> exception
                        .authenticationEntryPoint((request, response, authException) -> 
                                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized")
                        )
                        .accessDeniedHandler((request, response, accessDeniedException) -> 
                                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied")
                        )
                )

                // Cấu hình authorization cho các endpoints
                .authorizeHttpRequests(authorize -> authorize
                        // Public static pages
                        .requestMatchers("/", "/index.html", "/auth.html").permitAll()
                        // Public static resources
                        .requestMatchers("/css/**", "/js/**", "/favicon.ico").permitAll()
                        // Health check endpoint
                        .requestMatchers(HttpMethod.GET, "/actuator/health").permitAll()
                        // Public auth endpoints - CHỈ register và login
                        .requestMatchers("/api/auth/register", "/api/auth/login").permitAll()
                        // Tất cả request khác yêu cầu xác thực
                        .anyRequest().authenticated()
                )

                // Đăng ký authentication provider
                .authenticationProvider(authProvider())

                // Thêm JWT filter trước UsernamePasswordAuthenticationFilter
                .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    /**
     * Bean AuthenticationManager để xử lý authentication
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
