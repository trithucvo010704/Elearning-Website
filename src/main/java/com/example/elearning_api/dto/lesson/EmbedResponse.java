package com.example.elearning_api.dto.lesson;
/**
 * Response khi FE hỏi /embed. Nếu canWatch=false -> embedUrl null,
 * FE sẽ hiện paywall/CTA thay vì render iframe.
 */
public record EmbedResponse(
        boolean canWatch, String provider, String videoId, String embedUrl
) {
}
