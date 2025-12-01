package com.example.elearning_api.service.admin;

import com.example.elearning_api.Enum.CourseStatus;
import com.example.elearning_api.Enum.Role;
import com.example.elearning_api.dto.admin.AdminStatistics;
import com.example.elearning_api.entity.*;
import com.example.elearning_api.exception.ResourceNotFoundException;
import com.example.elearning_api.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

@Service
@RequiredArgsConstructor
public class AdminService {
    private final UserRepository userRepo;
    private final CourseRepository courseRepo;
    private final EnrollmentRepository enrollmentRepo;
    private final PaymentRepository paymentRepo;
    private final CourseInstructorRepo courseInstructorRepo;
    private final VideoLessonRepo videoLessonRepo;
    private final OrderItemRepository orderItemRepo;
    private final LessonProgressRepository lessonProgressRepo;

    /**
     * Retrieves all users in the system
     * @return List of all users
     */
    public List<User> getAllUsers() {
        return userRepo.findAll();
    }

    /**
     * Updates a user's role
     * @param userId The ID of the user to update
     * @param newRole The new role to assign
     * @return The updated user
     * @throws ResourceNotFoundException if user not found
     * @throws IllegalArgumentException if userId or newRole is null
     */
    @Transactional
    public User updateUserRole(Long userId, Role newRole) {
        Assert.notNull(userId, "User ID must not be null");
        Assert.notNull(newRole, "New role must not be null");

        User user = userRepo.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User", "id", userId));
        user.setRole(newRole);
        return userRepo.save(user);
    }

    /**
     * Deletes a user from the system
     * @param userId The ID of the user to delete
     * @throws ResourceNotFoundException if user not found
     */
    @Transactional
    public void deleteUser(Long userId) {
        Assert.notNull(userId, "User ID must not be null");
        if (!userRepo.existsById(userId)) {
            throw new ResourceNotFoundException("User", "id", userId);
        }
        userRepo.deleteById(userId);
    }

    /**
     * Retrieves all courses in the system
     * @return List of all courses
     */
    public List<Course> getAllCourses() {
        return courseRepo.findAll();
    }

    /**
     * Updates a course's status
     * @param courseId The ID of the course to update
     * @param status The new status to set
     * @return The updated course
     * @throws ResourceNotFoundException if course not found
     * @throws IllegalArgumentException if courseId or status is null
     */
    @Transactional
    public Course updateCourseStatus(Long courseId, CourseStatus status) {
        Assert.notNull(courseId, "Course ID must not be null");
        Assert.notNull(status, "Status must not be null");

        Course course = courseRepo.findById(courseId)
                .orElseThrow(() -> new ResourceNotFoundException("Course", "id", courseId));
        course.setStatus(status);
        return courseRepo.save(course);
    }

    /**
     * Deletes a course from the system
     * Xóa course và tất cả dữ liệu liên quan (course_instructors, enrollments, order_items, video_lessons, lesson_progress)
     * @param courseId The ID of the course to delete
     * @throws ResourceNotFoundException if course not found
     */
    @Transactional
    public void deleteCourse(Long courseId) {
        Assert.notNull(courseId, "Course ID must not be null");
        
        // Kiểm tra course có tồn tại không
        if (!courseRepo.existsById(courseId)) {
            throw new ResourceNotFoundException("Course", "id", courseId);
        }
        
        // Xóa tất cả dữ liệu liên quan trước khi xóa course
        // Thứ tự xóa quan trọng: phải xóa bảng con trước, bảng cha sau
        
        // 1. Xóa LessonProgress (tham chiếu đến VideoLesson và Enrollment)
        lessonProgressRepo.deleteByCourseId(courseId);
        
        // 2. Xóa VideoLesson (tham chiếu đến Course)
        videoLessonRepo.deleteByCourseId(courseId);
        
        // 3. Xóa Enrollment (tham chiếu đến Course)
        enrollmentRepo.deleteByCourseId(courseId);
        
        // 4. Xóa OrderItem (tham chiếu đến Course)
        orderItemRepo.deleteByCourseId(courseId);
        
        // 5. Xóa CourseInstructor (tham chiếu đến Course) - đây là nguyên nhân lỗi ban đầu
        courseInstructorRepo.deleteByCourseId(courseId);
        
        // 6. Cuối cùng mới xóa Course
        courseRepo.deleteById(courseId);
    }

    /**
     * Get overall system statistics
     * @return AdminStatistics object containing various system metrics
     */
    public AdminStatistics getStatistics() {
        long totalUsers = userRepo.count();
        long totalCourses = courseRepo.count();
        long totalInstructors = userRepo.countByRole(Role.INSTRUCTOR);
        long totalRevenue = calculateTotalRevenue();
        long activeEnrollments = enrollmentRepo.countActive();

        return AdminStatistics.builder()
                .totalUsers(totalUsers)
                .totalCourses(totalCourses)
                .totalInstructors(totalInstructors)
                .totalRevenue(totalRevenue)
                .activeEnrollments(activeEnrollments)
                .revenueStats(calculateRevenueStats())
                .build();
    }

    /**
     * Get revenue statistics for a specific period
     * @param period The period to get statistics for ("daily", "monthly", or "yearly")
     * @return Map containing period and aggregated revenue data
     */
    public Map<String, Object> getRevenueStatistics(String period) {
        Assert.notNull(period, "Period must not be null");
        
        LocalDateTime startDate;
        LocalDateTime now = LocalDateTime.now();

        switch (period.toLowerCase()) {
            case "daily":
                startDate = now.minusDays(30); // Last 30 days
                break;
            case "yearly":
                startDate = now.minusYears(1); // Last year
                break;
            case "monthly":
                startDate = now.minusMonths(12); // Last 12 months
                break;
            default:
                throw new IllegalArgumentException("Invalid period. Must be 'daily', 'monthly', or 'yearly'");
        }

        List<Payment> payments = paymentRepo.findByCreatedAtAfter(startDate);

        // Group and sum payments based on period
        Map<String, Long> stats = new TreeMap<>(); // Using TreeMap for sorted keys
        
        for (Payment payment : payments) {
            String key = formatDateByPeriod(payment.getCreatedAt(), period);
            stats.merge(key, payment.getAmount(), Long::sum);
        }

        return Map.of(
                "period", period,
                "data", stats);
    }

    private String formatDateByPeriod(LocalDateTime date, String period) {
        return switch (period.toLowerCase()) {
            case "daily" -> date.toLocalDate().toString();
            case "yearly" -> String.valueOf(date.getYear());
            default -> String.format("%d-%02d", date.getYear(), date.getMonthValue());
        };
    }

    // Instructor Management
    public List<User> getInstructors() {
        return userRepo.findByRole(Role.INSTRUCTOR);
    }

    @Transactional
    public User makeInstructor(Long userId) {
        User user = userRepo.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        user.setRole(Role.INSTRUCTOR);
        return userRepo.save(user);
    }

    // Helper methods
    private long calculateTotalRevenue() {
        return paymentRepo.sumTotalAmount();
    }

    private AdminStatistics.RevenueStats calculateRevenueStats() {
        LocalDateTime now = LocalDateTime.now();

        return AdminStatistics.RevenueStats.builder()
                .daily(paymentRepo.sumAmountAfter(now.minusDays(1)))
                .weekly(paymentRepo.sumAmountAfter(now.minusWeeks(1)))
                .monthly(paymentRepo.sumAmountAfter(now.minusMonths(1)))
                .yearly(paymentRepo.sumAmountAfter(now.minusYears(1)))
                .build();
    }
}