package com.example.elearning_api.service;

import com.example.elearning_api.config.VideoProps;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.security.access.AccessDeniedException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * Build URL đúng bài: youtube-nocookie + enablejsapi=1 + origin (whitelist).
 * Doc & lý do privacy/lazy-load/params -> theo plan tuần 3.
 */
@Service
@RequiredArgsConstructor
public class YoutubeProvider implements VideoProvider {
    private final VideoProps props;

    @Override
    public boolean supports(String key) {
        return key != null && key.startsWith("yt:");
    }

    @Override
    public String extractVideoId(String key) {
        if (!supports(key))
            throw new IllegalArgumentException("Invalid providerKey");
        return key.substring(3);
    }

    @Override
    public String buildEmbedUrl(String key, String origin) {
        if (!props.getAllowedOrigins().contains(origin))
            throw new AccessDeniedException("Origin not allowed");
        String id = extractVideoId(key);
        String q = "rel=0&modestbranding=1&playsinline=1&enablejsapi=1&origin=" +
                URLEncoder.encode(origin, StandardCharsets.UTF_8);
        return "https://www.youtube-nocookie.com/embed/" + id + "?" + q;
    }
}
