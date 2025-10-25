package com.example.elearning_api.dto.admin;

import com.example.elearning_api.Enum.CourseStatus;
import lombok.Data;

@Data
public class CourseStatusRequest {
    private CourseStatus status; // PENDING, APPROVED, REJECTED
}