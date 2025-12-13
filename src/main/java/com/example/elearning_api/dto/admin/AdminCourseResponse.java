package com.example.elearning_api.dto.admin;

import com.example.elearning_api.Enum.CourseStatus;
import com.example.elearning_api.entity.Course;
import com.example.elearning_api.entity.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AdminCourseResponse {
    private Long id;
    private String title;
    private String slug;
    private String description;
    private Integer priceCents;
    private String currency;
    private Boolean published;
    private String thumbnailUrl;
    private CourseStatus status;
    private InstructorInfo instructor;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class InstructorInfo {
        private Long id;
        private String username;
        private String fullName;
    }

    public static AdminCourseResponse fromCourse(Course course, User instructor) {
        AdminCourseResponseBuilder builder = AdminCourseResponse.builder()
                .id(course.getId())
                .title(course.getTitle())
                .slug(course.getSlug())
                .description(course.getDescription())
                .priceCents(course.getPriceCents())
                .currency(course.getCurrency())
                .published(course.isPublished())
                .thumbnailUrl(course.getThumbnailUrl())
                .status(course.getStatus());

        if (instructor != null) {
            builder.instructor(InstructorInfo.builder()
                    .id(instructor.getId())
                    .username(instructor.getUsername())
                    .fullName(instructor.getFullName())
                    .build());
        }

        return builder.build();
    }
}

