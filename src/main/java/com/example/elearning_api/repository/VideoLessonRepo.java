package com.example.elearning_api.repository;

import com.example.elearning_api.entity.VideoLesson;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface VideoLessonRepo extends BaseRepo<VideoLesson> {

    List<VideoLesson> findByCourseIdAndDeletedAtIsNullOrderByOrderIndexAsc(Long courseId);

    Optional<VideoLesson> findByIdAndCourseIdAndDeletedAtIsNull(Long id, Long courseId);

    @Query("SELECT COUNT(v) > 0 FROM VideoLesson v WHERE v.course.id = :courseId AND v.orderIndex = :orderIndex AND v.deletedAt IS NULL")
    boolean existsByCourseIdAndOrderIndexAndDeletedAtIsNull(@Param("courseId") Long courseId,
            @Param("orderIndex") int orderIndex);
    
    // Xóa tất cả VideoLesson của một course
    @Modifying
    @Transactional
    @Query("DELETE FROM VideoLesson v WHERE v.course.id = :courseId")
    void deleteByCourseId(@Param("courseId") Long courseId);
}
