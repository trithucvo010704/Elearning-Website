package com.example.elearning_api.service;
/** Interface để sau này switch provider dễ (YouTube/Vimeo/Self-host HLS). */
public interface VideoProvider {
    boolean supports(String providerKey);
    String extractVideoId(String providerKey);
    String buildEmbedUrl(String providerKey, String origin);
}
