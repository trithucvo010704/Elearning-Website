package com.example.elearning_api.dto.lesson;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;

public record CreateLessonManualRequest(
        @NotBlank String title,
        @NotNull Integer orderIndex ,
        @NotNull Integer durationSec,
        @NotNull Boolean freePreview ,
        @Pattern(regexp = "^[a-zA-Z0-9_-]{6,}$", message="Invalid YouTube Video ID")
        String youtubeVideoId
) { }
