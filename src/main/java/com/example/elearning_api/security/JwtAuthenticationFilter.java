package com.example.elearning_api.security;

import com.example.elearning_api.repository.UserRepo;
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

@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {
    private final JwtService jwtService;
    private final UserRepo userRepository;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        // Bỏ qua nếu đã có Authentication (tránh set 2 lần)
        if (SecurityContextHolder.getContext().getAuthentication() == null) {
            String authHeader = request.getHeader(HttpHeaders.AUTHORIZATION);

            if (authHeader != null && authHeader.startsWith("Bearer ")) {
                String token = authHeader.substring(7).trim(); // TRIM để tránh case xuống dòng

                try {
                    String username = jwtService.extractSubject(token); // subject = username
                    if (username != null) {
                        userRepository.findByUsername(username).ifPresent(user -> {
                            // QUYỀN phải có prefix "ROLE_"
                            var authorities = List.of(new SimpleGrantedAuthority("ROLE_" + user.getRole().name()));
                            var authentication = new UsernamePasswordAuthenticationToken(user.getUsername(), null, authorities);
                            authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                            SecurityContextHolder.getContext().setAuthentication(authentication);
                        });
                    }
                } catch (JwtException | IllegalArgumentException e) {
                    // Token hỏng/hết hạn → để AuthenticationEntryPoint trả 401
                }
            }
        }

        // Luôn gọi tiếp filter chain đúng 1 lần
        filterChain.doFilter(request, response);
    }
}
