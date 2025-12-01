package com.example.elearning_api.repository;

import com.example.elearning_api.entity.Enrollment;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface EnrollmentRepository extends JpaRepository<Enrollment, Long> {
    @Query("SELECT COUNT(e) FROM Enrollment e WHERE e.status = 'ACTIVE'")
    long countActive();
    
    // Xóa tất cả Enrollment của một course
    @Modifying
    @Transactional
    @Query("DELETE FROM Enrollment e WHERE e.course.id = :courseId")
    void deleteByCourseId(@Param("courseId") Long courseId);
}