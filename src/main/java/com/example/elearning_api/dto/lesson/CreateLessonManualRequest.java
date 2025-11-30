package com.example.elearning_api.dto.lesson;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Min;

public record CreateLessonManualRequest(
        @NotBlank(message = "Tiêu đề không được để trống") 
        String title,
        
        @NotNull(message = "Thứ tự không được để trống")
        @Min(value = 0, message = "Thứ tự phải >= 0")
        Integer orderIndex,
        
        @NotNull(message = "Thời lượng không được để trống")
        @Min(value = 1, message = "Thời lượng phải >= 1 giây")
        Integer durationSec,
        
        @NotNull(message = "Trạng thái xem thử không được để trống")
        Boolean freePreview,
        
        @NotBlank(message = "YouTube Video ID không được để trống")
        @Pattern(regexp = "^[a-zA-Z0-9_-]{6,}$", message = "YouTube Video ID không hợp lệ (cần ít nhất 6 ký tự)")
        String youtubeVideoId
) { }
