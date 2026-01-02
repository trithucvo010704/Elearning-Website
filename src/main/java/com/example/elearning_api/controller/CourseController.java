package com.example.elearning_api.controller;

import com.example.elearning_api.dto.course.CreateCourseRequest;
import com.example.elearning_api.entity.Course;
import com.example.elearning_api.entity.CourseInstructor;
import com.example.elearning_api.entity.Enrollment;
import com.example.elearning_api.Enum.InstructorRole;
import com.example.elearning_api.Enum.EnrollmentStatus;
import com.example.elearning_api.exception.CourseNotFoundException;
import com.example.elearning_api.repository.CourseInstructorRepo;
import com.example.elearning_api.repository.CourseRepository;
import com.example.elearning_api.repository.EnrollmentRepository;
import com.example.elearning_api.security.UserPrincipal;
import com.example.elearning_api.util.SlugUtil;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/courses")
@RequiredArgsConstructor
public class CourseController {
    private final CourseRepository courseRepo;
    private final CourseInstructorRepo instructorRepo;
    private final EnrollmentRepository enrollmentRepo;

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    @PreAuthorize("hasAnyRole('INSTRUCTOR', 'ADMIN')")
    public Course createCourse(
            @Valid @RequestBody CreateCourseRequest req,
            @AuthenticationPrincipal UserPrincipal user) {

        try {
            System.out.println("=== CREATE COURSE START ===");
            System.out.println("User: " + user.getUsername());
            System.out.println("Title: " + req.getTitle());

            Course course = new Course();
            course.setTitle(req.getTitle());
            course.setDescription(req.getDescription());
            course.setPriceCents(req.getPriceCents().intValue());
            course.setCurrency(req.getCurrency());
            course.setThumbnailUrl(req.getThumbnailUrl());

            // Generate unique slug (add suffix if duplicate)
            String baseSlug = SlugUtil.normalize(req.getTitle());
            String slug = baseSlug;
            int suffix = 1;
            while (courseRepo.existsBySlug(slug)) {
                slug = baseSlug + "-" + suffix;
                suffix++;
            }
            course.setSlug(slug);
            System.out.println("Generated slug: " + slug);

            course = courseRepo.save(course);

            // Assign creator as OWNER
            CourseInstructor instructor = new CourseInstructor();
            instructor.setCourse(course);
            instructor.setUser(user.getUser());
            instructor.setRole(InstructorRole.OWNER);

            instructorRepo.save(instructor);

            return course;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @PutMapping("/{id}")
    @PreAuthorize("@courseSecurity.canEdit(#id, #user)")
    public Course updateCourse(
            @PathVariable Long id,
            @Valid @RequestBody CreateCourseRequest req,
            @AuthenticationPrincipal UserPrincipal user) {

        Course course = courseRepo.findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() -> new CourseNotFoundException("Course not found with id: " + id));

        course.setCurrency(req.getCurrency());
        course.setThumbnailUrl(req.getThumbnailUrl());
        course.setSlug(SlugUtil.normalize(req.getTitle()));
        course.setTitle(req.getTitle());
        course.setDescription(req.getDescription());
        course.setPriceCents(req.getPriceCents().intValue());

        return courseRepo.save(course);
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @PreAuthorize("@courseSecurity.canEdit(#id, #user)")
    public void deleteCourse(
            @PathVariable Long id,
            @AuthenticationPrincipal UserPrincipal user) {

        Course course = courseRepo.findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() -> new CourseNotFoundException("Course not found with id: " + id));
        course.setDeletedAt(LocalDateTime.now());
        courseRepo.save(course);
    }

    @GetMapping
    public List<Course> listCourses(
            @RequestParam(required = false) boolean mine,
            @AuthenticationPrincipal UserPrincipal user) {

        if (mine && user != null) {
            System.out.println("DEBUG: Fetching courses for instructor ID: " + user.getUser().getId());
            List<Course> courses = courseRepo.findAllByInstructor(user.getUser().getId());
            System.out.println("DEBUG: Found " + courses.size() + " courses.");
            if (courses.isEmpty()) {
                // Fallback check: Check if any course instructors exist for this user ignoring
                // deletedAt
                System.out.println("DEBUG: Checking raw DB...");
            }
            return courses;
        }
        return courseRepo.findAll();
    }

    @GetMapping("/{id}/enrollment-status")
    public Map<String, Object> checkEnrollmentStatus(
            @PathVariable Long id,
            @AuthenticationPrincipal UserPrincipal user) {

        Map<String, Object> response = new HashMap<>();

        if (user == null) {
            response.put("enrolled", false);
            response.put("status", null);
            return response;
        }

        Course course = courseRepo.findByIdAndDeletedAtIsNull(id)
                .orElseThrow(() -> new CourseNotFoundException("Course not found with id: " + id));

        Enrollment enrollment = enrollmentRepo.findByUserAndCourse(user.getUser(), course);

        if (enrollment != null && enrollment.getStatus() == EnrollmentStatus.ACTIVE) {
            response.put("enrolled", true);
            response.put("status", enrollment.getStatus().toString());
            response.put("enrolledAt", enrollment.getCreatedAt());
        } else {
            response.put("enrolled", false);
            response.put("status", enrollment != null ? enrollment.getStatus().toString() : null);
        }

        return response;
    }
}