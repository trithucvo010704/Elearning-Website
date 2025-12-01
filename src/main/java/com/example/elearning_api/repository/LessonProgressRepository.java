package com.example.elearning_api.repository;

import com.example.elearning_api.entity.LessonProgress;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface LessonProgressRepository extends JpaRepository<LessonProgress, Long> {
    /**
     * Xóa tất cả LessonProgress liên quan đến một course
     * LessonProgress có thể tham chiếu đến course thông qua:
     * - VideoLesson (lp.lesson.course.id)
     * - Enrollment (lp.enrollment.course.id)
     */
    @Modifying
    @Transactional
    @Query("DELETE FROM LessonProgress lp WHERE lp.lesson.course.id = :courseId OR lp.enrollment.course.id = :courseId")
    void deleteByCourseId(@Param("courseId") Long courseId);
}

