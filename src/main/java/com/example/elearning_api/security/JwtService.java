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

    public JwtService(@Value("${app.jwt.secret}") String secret,
                      @Value("${app.jwt.expirySeconds:86400}") long expirySeconds) {
        if (secret == null || secret.length() < 32) {
            throw new IllegalArgumentException("Secret length must be greater than 32 characters");
        }
        this.key = Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
        this.expiryMillis = expirySeconds * 1000;
    }
    /** API CHUẨN: dùng trong AuthService */
    public String generateToken(String subject, Map<String, Object> claims) {
        long now = System.currentTimeMillis();
        JwtBuilder builder = Jwts.builder()
                .setSubject(subject)
                .setIssuedAt(new Date(now))
                .setExpiration(new Date(now + expiryMillis))
                .signWith(key, SignatureAlgorithm.HS256);
        if (claims != null && !claims.isEmpty()) builder.setClaims(claims).setSubject(subject);
        return builder.compact();
    }


    /** API CHUẨN: dùng trong JwtAuthFilter */
    public String extractSubject(String token) {
        return parseClaims(token).getSubject();
    }

    public String extractUsername(String token) {
        return Jwts.parserBuilder().setSigningKey(key).build()
                .parseClaimsJws(token).getBody().getSubject();
    }

    public boolean isValid(String token, UserDetails user) {
        try {
            var claims = Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token)
                    .getBody();
            return claims.getSubject().equals(user.getUsername()) &&
                    claims.getExpiration().after(new Date());
        } catch (JwtException e) {
            return false;
        }
    }

    public boolean isValidForUser(String token, String expectedUsername) {
        try {
            var claims = parseClaims(token);
            return expectedUsername.equals(claims.getSubject()) && claims.getExpiration().after(new Date());
        } catch (JwtException | IllegalArgumentException e) {
            return false;
        }
    }

    public Claims parseClaims(String token) {
        return Jwts.parserBuilder().setSigningKey(key).build()
                .parseClaimsJws(token).getBody();
    }
}
