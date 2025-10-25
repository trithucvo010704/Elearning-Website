package com.example.elearning_api.repository;

import com.example.elearning_api.Enum.InstructorRole;
import com.example.elearning_api.entity.CourseInstructor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface CourseInstructorRepo extends BaseRepo<CourseInstructor> {

    // Kiểm tra sự tồn tại của instructor
    boolean existsByCourseIdAndUserId(Long courseId, Long userId);

    // Kiểm tra quyền chỉnh sửa (instructor phải active và có role phù hợp)
    @Query("SELECT COUNT(ci) > 0 FROM CourseInstructor ci " +
            "WHERE ci.course.id = :courseId AND ci.user.id = :userId " +
            "AND ci.deletedAt IS NULL AND ci.role IN ('OWNER', 'EDITOR')")
    boolean canWrite(@Param("courseId") Long courseId, @Param("userId") Long userId);

    // Kiểm tra quyền sở hữu khóa học
    @Query("SELECT COUNT(ci) > 0 FROM CourseInstructor ci " +
            "WHERE ci.course.id = :courseId AND ci.user.id = :userId " +
            "AND ci.deletedAt IS NULL AND ci.role = 'OWNER'")
    boolean isOwner(@Param("courseId") Long courseId, @Param("userId") Long userId);

    // Lấy tất cả instructor của một khóa học
    @Query("SELECT ci FROM CourseInstructor ci " +
            "WHERE ci.course.id = :courseId AND ci.deletedAt IS NULL " +
            "ORDER BY ci.role, ci.createdAt")
    List<CourseInstructor> findActiveByCourseId(@Param("courseId") Long courseId);

    // Lấy instructor cụ thể của khóa học
    @Query("SELECT ci FROM CourseInstructor ci " +
            "WHERE ci.course.id = :courseId AND ci.user.id = :userId " +
            "AND ci.deletedAt IS NULL")
    Optional<CourseInstructor> findActiveByCourseIdAndUserId(
            @Param("courseId") Long courseId,
            @Param("userId") Long userId);

    // Đếm số lượng owner của khóa học
    @Query("SELECT COUNT(ci) FROM CourseInstructor ci " +
            "WHERE ci.course.id = :courseId AND ci.deletedAt IS NULL " +
            "AND ci.role = 'OWNER'")
    long countOwners(@Param("courseId") Long courseId);

    // Kiểm tra role của instructor
    @Query("SELECT ci.role FROM CourseInstructor ci " +
            "WHERE ci.course.id = :courseId AND ci.user.id = :userId " +
            "AND ci.deletedAt IS NULL")
    Optional<InstructorRole> findRole(@Param("courseId") Long courseId, @Param("userId") Long userId);
}
