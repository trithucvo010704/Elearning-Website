package com.example.elearning_api.repository;

import com.example.elearning_api.entity.Course;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CourseRepository extends BaseRepo<Course> {

    /**
     * Find course by ID with soft delete check.
     */
    Optional<Course> findByIdAndDeletedAtIsNull(Long id);

    /**
     * Find all courses by instructor ID (only non-deleted Course & CourseInstructor).
     */
    @Query("""
           SELECT DISTINCT c
           FROM Course c
           JOIN CourseInstructor ci ON c.id = ci.course.id
           WHERE ci.user.id = :instructorId
             AND c.deletedAt IS NULL
             AND ci.deletedAt IS NULL
           """)
    List<Course> findAllByInstructor(@Param("instructorId") Long instructorId);

    /**
     * Check if slug exists (for unique slug generation).
     */
    boolean existsBySlug(String slug);
}
