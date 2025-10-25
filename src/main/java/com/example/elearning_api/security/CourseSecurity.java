package com.example.elearning_api.security;

import com.example.elearning_api.repository.CourseInstructorRepo;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

@Component("courseSecurity")
public class CourseSecurity {
    private final CourseInstructorRepo ciRepo;

    public CourseSecurity(CourseInstructorRepo ciRepo) {
        this.ciRepo = ciRepo;
    }

    public boolean canEdit(Long courseId, UserPrincipal user) {
        if (user == null) {
            return false;
        }
        boolean isAdmin = user.hasRole(com.example.elearning_api.Enum.Role.ADMIN);
        if (isAdmin)
            return true;
        Long userId = user.getUser().getId();
        return userId != null && ciRepo.canWrite(courseId, userId);
    }

    public boolean canWrite(Long courseId, Authentication auth) {
        if (auth == null) {
            return false;
        }
        boolean isAdmin = auth.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
        if (isAdmin)
            return true;
        Long userId = principalId(auth);
        return userId != null && ciRepo.canWrite(courseId, userId);
    }

    private Long principalId(Authentication auth) {
        try {
            return (Long) auth.getPrincipal().getClass().getMethod("getId").invoke(auth.getPrincipal());
        } catch (Exception e) {
            return null;
        }
    }
}
