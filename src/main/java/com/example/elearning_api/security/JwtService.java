package com.example.elearning_api.security;

import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.Map;

@Component
public class JwtService {
    private final SecretKey key;
    private final long expiryMillis;

    // Constructor: Inject secret từ properties (lưu ý typo: }) thay vì }").
    public JwtService(@Value("${app.jwt.secret}") String secret,
            @Value("${app.jwt.expirySeconds:86400}") long expirySeconds) {
        if (secret == null || secret.length() < 32) {
            throw new IllegalArgumentException("Secret length must be greater than 32 characters");
        }
        this.key = Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8)); // Tạo key HS256 từ secret bytes.
        this.expiryMillis = expirySeconds * 1000;
    }

    /** API CHUẨN: dùng trong AuthService */
    // Method generate token: Subject (username), claims tùy chọn
    public String generateToken(String subject, Map<String, Object> claims) {
        long now = System.currentTimeMillis();
        JwtBuilder builder = Jwts.builder()
                .setSubject(subject)
                .setIssuedAt(new Date(now))
                .setExpiration(new Date(now + expiryMillis))
                .signWith(key, SignatureAlgorithm.HS256);// Sign với key và alg HS256.

        // FIX: Thêm claims custom mà không overwrite subject, issuedAt, expiration
        if (claims != null && !claims.isEmpty()) {
            claims.forEach(builder::claim); // Thêm từng claim riêng lẻ
        }

        return builder.compact();
    }

    /** API CHUẨN: dùng trong JwtAuthFilter */
    public String extractSubject(String token) {
        return parseClaims(token).getSubject();
    }

    public String extractUsername(String token) { // Method extract username (tương tự subject).
        return Jwts.parserBuilder().setSigningKey(key).build()
                .parseClaimsJws(token).getBody().getSubject();
    }

    public boolean isValid(String token, UserDetails user) {
        try {
            var claims = Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token)
                    .getBody();
            return claims.getSubject().equals(user.getUsername()) &&
                    claims.getExpiration().after(new Date());// Check chưa hết hạn.
        } catch (JwtException e) {
            return false;
        }
    }

    public boolean isValidForUser(String token, String expectedUsername) {
        try {
            var c = parseClaims(token);
            return expectedUsername.equals(c.getSubject()) && c.getExpiration().after(new Date());
        } catch (JwtException | IllegalArgumentException e) {
            return false;
        }
    }

    public Claims parseClaims(String token) {
        return Jwts.parserBuilder().setSigningKey(key).build()
                .parseClaimsJws(token).getBody();
    }
}
