package com.example.elearning_api.service;

import com.example.elearning_api.entity.Enrollment;
import com.example.elearning_api.entity.VideoLesson;
import com.example.elearning_api.Enum.EnrollmentStatus;
import com.example.elearning_api.Enum.Role;
import com.example.elearning_api.repository.EnrollmentRepository;
import com.example.elearning_api.security.UserPrincipal;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * Điều kiện xem video:
 * - freePreview = true => ai cũng xem
 * - user != null && (ROLE_ADMIN || ROLE_INSTRUCTOR) => xem
 * - nếu đã enroll với status ACTIVE => xem
 */
@Service
@RequiredArgsConstructor
public class GatingService {
    private final EnrollmentRepository enrollmentRepo;
    
    public boolean canWatch(UserPrincipal user, VideoLesson l) {
        if (l.isFreePreview())
            return true;
        if (user == null)
            return false;
        if (user.hasRole(Role.ADMIN) || user.hasRole(Role.INSTRUCTOR))
            return true;
        
        // Check if user is enrolled in the course with ACTIVE status
        Enrollment enrollment = enrollmentRepo.findByUserAndCourse(user.getUser(), l.getCourse());
        if (enrollment != null && enrollment.getStatus() == EnrollmentStatus.ACTIVE) {
            return true;
        }
        
        return false;
    }
}
