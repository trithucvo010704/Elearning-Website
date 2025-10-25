package com.example.elearning_api.service;

import com.example.elearning_api.entity.VideoLesson;
import com.example.elearning_api.Enum.Role;
import com.example.elearning_api.security.UserPrincipal;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * Điều kiện xem video tuần 3:
 * - freePreview = true => ai cũng xem
 * - user != null && (ROLE_ADMIN || ROLE_INSTRUCTOR) => xem
 * - (Tuần 5) nếu đã enroll => xem
 */
@Service
@RequiredArgsConstructor
public class GatingService {
    // NOTE: tuần 5 sẽ inject EnrollmentRepository để check enroll thực tế
    public boolean canWatch(UserPrincipal user, VideoLesson l) {
        if (l.isFreePreview())
            return true;
        if (user == null)
            return false;
        if (user.hasRole(Role.ADMIN) || user.hasRole(Role.INSTRUCTOR))
            return true;
        // TODO (Tuần 5): return enrollmentRepo.existsActive(l.getCourseId(),
        // user.getId());
        return false;
    }
}
