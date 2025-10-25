package com.example.elearning_api.controller;

import com.example.elearning_api.dto.admin.*;
import com.example.elearning_api.entity.*;
import com.example.elearning_api.Enum.*;
import com.example.elearning_api.service.admin.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/admin")
@PreAuthorize("hasRole('ADMIN')")
@RequiredArgsConstructor
public class AdminController {
    private final AdminService adminService;

    // User Management
    @GetMapping("/users")
    public ResponseEntity<List<User>> getAllUsers() {
        return ResponseEntity.ok(adminService.getAllUsers());
    }

    @PutMapping("/users/{userId}/role")
    public ResponseEntity<User> updateUserRole(
            @PathVariable Long userId,
            @RequestBody RoleUpdateRequest request) {
        return ResponseEntity.ok(adminService.updateUserRole(userId, request.getRole()));
    }

    @DeleteMapping("/users/{userId}")
    public ResponseEntity<?> deleteUser(@PathVariable Long userId) {
        adminService.deleteUser(userId);
        return ResponseEntity.ok().build();
    }

    // Course Management
    @GetMapping("/courses")
    public ResponseEntity<List<Course>> getAllCourses() {
        return ResponseEntity.ok(adminService.getAllCourses());
    }

    @PutMapping("/courses/{courseId}/status")
    public ResponseEntity<Course> updateCourseStatus(
            @PathVariable Long courseId,
            @RequestBody CourseStatusRequest request) {
        return ResponseEntity.ok(adminService.updateCourseStatus(courseId, request.getStatus()));
    }

    @DeleteMapping("/courses/{courseId}")
    public ResponseEntity<?> deleteCourse(@PathVariable Long courseId) {
        adminService.deleteCourse(courseId);
        return ResponseEntity.ok().build();
    }

    // Statistics
    @GetMapping("/statistics")
    public ResponseEntity<AdminStatistics> getStatistics() {
        return ResponseEntity.ok(adminService.getStatistics());
    }

    @GetMapping("/statistics/revenue")
    public ResponseEntity<Map<String, Object>> getRevenueStats(
            @RequestParam(required = false) String period // daily, monthly, yearly
    ) {
        return ResponseEntity.ok(adminService.getRevenueStatistics(period));
    }

    // Instructor Management
    @GetMapping("/instructors")
    public ResponseEntity<List<User>> getInstructors() {
        return ResponseEntity.ok(adminService.getInstructors());
    }

    @PostMapping("/instructors/{userId}")
    public ResponseEntity<User> makeInstructor(@PathVariable Long userId) {
        return ResponseEntity.ok(adminService.makeInstructor(userId));
    }
}