package com.example.elearning_api.controller;

import com.example.elearning_api.dto.course.CreateCourseRequest;
import com.example.elearning_api.entity.Course;
import com.example.elearning_api.entity.CourseInstructor;
import com.example.elearning_api.Enum.InstructorRole;
import com.example.elearning_api.exception.CourseNotFoundException;
import com.example.elearning_api.repository.CourseInstructorRepo;
import com.example.elearning_api.repository.CourseRepository;
import com.example.elearning_api.security.UserPrincipal;
import com.example.elearning_api.util.SlugUtil;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/courses")
@RequiredArgsConstructor
public class CourseController {
    private final CourseRepository courseRepo;
    private final CourseInstructorRepo instructorRepo;

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
            System.out.println("✅ Course saved with ID: " + course.getId());

            // Assign creator as OWNER
            System.out.println("Creating CourseInstructor...");
            CourseInstructor instructor = new CourseInstructor();
            instructor.setCourse(course);
            instructor.setUser(user.getUser());
            instructor.setRole(InstructorRole.OWNER);

            System.out.println("Course ID: " + (course != null ? course.getId() : "null"));
            System.out.println("User ID: " + (user.getUser() != null ? user.getUser().getId() : "null"));
            System.out.println("Role: " + InstructorRole.OWNER);

            instructorRepo.save(instructor);
            System.out.println("✅ CourseInstructor saved");

            System.out.println("=== CREATE COURSE SUCCESS ===");
            return course;
        } catch (Exception e) {
            System.err.println("=== CREATE COURSE ERROR ===");
            System.err.println("Error class: " + e.getClass().getName());
            System.err.println("Error message: " + e.getMessage());
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

        course.setTitle(req.getTitle());
        course.setDescription(req.getDescription());
        course.setPriceCents(req.getPriceCents().intValue());
        course.setCurrency(req.getCurrency());
        course.setThumbnailUrl(req.getThumbnailUrl());
        course.setSlug(SlugUtil.normalize(req.getTitle()));

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
            return courseRepo.findAllByInstructor(user.getUser().getId());
        }
        return courseRepo.findAll();
    }
}