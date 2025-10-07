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

@Component @RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {
    private final JwtService jwt ;
    private final UserRepo users ;
    @Override
    protected void doFilterInternal (HttpServletRequest req , HttpServletResponse res , FilterChain chain)
    throws ServletException, IOException {
        // Bỏ qua nếu đã có Authentication (tránh set 2 lần)
        if (SecurityContextHolder.getContext().getAuthentication() == null) {
            String header = req.getHeader(HttpHeaders.AUTHORIZATION);

            if (header != null && header.startsWith("Bearer ")) {
                String token = header.substring(7).trim(); // TRIM để tránh case xuống dòng

                try {
                    String username = jwt.extractSubject(token); // subject = username
                    if (username != null) {
                        users.findByUsername(username).ifPresent(u -> {
                            // QUYỀN phải có prefix "ROLE_"
                            var authorities = List.of(new SimpleGrantedAuthority("ROLE_" + u.getRole().name()));
                            var auth = new UsernamePasswordAuthenticationToken(u.getUsername(), null, authorities);
                            auth.setDetails(new WebAuthenticationDetailsSource().buildDetails(req));
                            SecurityContextHolder.getContext().setAuthentication(auth);
                        });
                    }
                } catch (JwtException | IllegalArgumentException e) {
                    // Token hỏng/hết hạn → để AuthenticationEntryPoint trả 401
                }
            }
        }

        // Luôn gọi tiếp filter chain đúng 1 lần
        chain.doFilter(req, res);
    }
}
