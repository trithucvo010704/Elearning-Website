package com.example.elearning_api.security;

import com.example.elearning_api.repository.UserRepository;
import io.jsonwebtoken.JwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.List;

// Đánh dấu là component (Spring tự scan và tạo bean), và tạo constructor với fields required.
@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {
    private final JwtService jwt; // Inject JwtService để parse/generate token.
    private final UserRepository users;

    @Override // Method xử lý filter: Nhận request, response, chain.
    protected void doFilterInternal(HttpServletRequest req, HttpServletResponse res, FilterChain chain)
            throws ServletException, IOException {
        // Bỏ qua nếu đã có Authentication (tránh set 2 lần)
        if (SecurityContextHolder.getContext().getAuthentication() == null) { // Kiểm tra nếu chưa có auth trong context
                                                                              // (tránh duplicate set)
            String header = req.getHeader(HttpHeaders.AUTHORIZATION);

            if (header != null && header.startsWith("Bearer ")) { // Kiểm tra nếu header tồn tại và bắt đầu bằng "Bearer
                                                                  // " (chuẩn JWT).
                String token = header.substring(7).trim(); // TRIM để tránh case xuống dòng // Extract token bằng cách
                                                           // cắt từ vị trí 7 (sau "Bearer "), và trim whitespace.

                try {
                    String username = jwt.extractSubject(token);
                    if (username != null) {
                        users.findByUsername(username).ifPresent(u -> {
                            // FIX: Tạo UserPrincipal thay vì chỉ dùng username
                            UserPrincipal principal = new UserPrincipal(u);

                            // Set principal object (UserPrincipal) vào auth token
                            var auth = new UsernamePasswordAuthenticationToken(
                                    principal, // ← Principal object, KHÔNG phải username string
                                    null,
                                    principal.getAuthorities());

                            auth.setDetails(new WebAuthenticationDetailsSource().buildDetails(req));
                            SecurityContextHolder.getContext().setAuthentication(auth);
                        });
                    }
                } catch (JwtException | IllegalArgumentException e) {
                    // Token hỏng/hết hạn → để AuthenticationEntryPoint trả 401
                }
            }
        }

        chain.doFilter(req, res);// Chuyển tiếp request đến filter tiếp theo hoặc controller, dù có auth hay
                                 // không.

    }
}
