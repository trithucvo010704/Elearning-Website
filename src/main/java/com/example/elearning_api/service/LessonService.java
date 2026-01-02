package com.example.elearning_api.service;

import com.example.elearning_api.entity.Course;
import com.example.elearning_api.entity.VideoLesson;
import com.example.elearning_api.repository.VideoLessonRepo;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LessonService {

    private final VideoLessonRepo repo;

    public LessonService(VideoLessonRepo repo) {
        this.repo = repo;
    }

    // =========================================================
    // CREATE
    // =========================================================
    @Transactional
    public VideoLesson createAfterUpload(
            Course course,
            String title,
            int orderIndex,
            boolean freePreview,
            Integer durationSec,
            String youtubeVideoId
    ) {
        validateCreateParams(course, title, orderIndex, durationSec, youtubeVideoId);
        ensureOrderIndexNotExists(course.getId(), orderIndex);

        VideoLesson lesson = buildVideoLesson(course, title, orderIndex, freePreview, durationSec, youtubeVideoId);
        return repo.save(lesson);
    }

    private void validateCreateParams(
            Course course,
            String title,
            int orderIndex,
            Integer durationSec,
            String youtubeVideoId
    ) {
        if (course == null) {
            throw new IllegalArgumentException("Course cannot be null");
        }
        if (title == null || title.isBlank()) {
            throw new IllegalArgumentException("Title cannot be null or blank");
        }
        if (orderIndex < 0) {
            throw new IllegalArgumentException("Order index cannot be negative");
        }
        if (durationSec != null && durationSec < 0) {
            throw new IllegalArgumentException("Duration cannot be negative");
        }
        if (youtubeVideoId == null || youtubeVideoId.isBlank()) {
            throw new IllegalArgumentException("YouTube video ID cannot be null or blank");
        }
    }

    private void ensureOrderIndexNotExists(Long courseId, int orderIndex) {
        boolean exists = repo.existsByCourseIdAndOrderIndexAndDeletedAtIsNull(courseId, orderIndex);
        if (exists) {
            throw new IllegalArgumentException("Order index already exists in this course");
        }
    }

    private VideoLesson buildVideoLesson(
            Course course,
            String title,
            int orderIndex,
            boolean freePreview,
            Integer durationSec,
            String youtubeVideoId
    ) {
        VideoLesson lesson = new VideoLesson();
        lesson.setCourse(course);
        lesson.setTitle(title);
        lesson.setOrderIndex(orderIndex);
        lesson.setFreePreview(freePreview);
        lesson.setDurationSec(durationSec);
        // quy ước lưu YouTube ID
        lesson.setS3Key("yt:" + youtubeVideoId);
        return lesson;
    }

    // =========================================================
    // READ
    // =========================================================
    public List<VideoLesson> listByCourse(Long courseId) {
        validateId(courseId, "Course ID cannot be null");
        return repo.findByCourseIdAndDeletedAtIsNullOrderByOrderIndexAsc(courseId);
    }

    public VideoLesson getInCourseOrThrow(Long courseId, Long lessonId) {
        validateId(courseId, "Course ID cannot be null");
        validateId(lessonId, "Lesson ID cannot be null");

        return repo.findByIdAndCourseIdAndDeletedAtIsNull(lessonId, courseId)
                .orElseThrow(() -> new IllegalArgumentException("Lesson not found"));
    }

    private void validateId(Long id, String message) {
        if (id == null) {
            throw new IllegalArgumentException(message);
        }
    }

    // =========================================================
    // UPDATE
    // =========================================================
    @Transactional
    public VideoLesson updateMeta(VideoLesson lesson, String title, Integer orderIndex, Boolean freePreview) {
        updateOrderIndexIfNeeded(lesson, orderIndex);
        updateTitleIfNeeded(lesson, title);
        updateFreePreviewIfNeeded(lesson, freePreview);
        return repo.save(lesson);
    }

    private void updateOrderIndexIfNeeded(VideoLesson lesson, Integer newOrderIndex) {
        if (newOrderIndex == null) {
            return;
        }

        Integer currentOrderIndex = lesson.getOrderIndex();
        if (newOrderIndex.equals(currentOrderIndex)) {
            return;
        }

        Long courseId = lesson.getCourse().getId();
        boolean exists = repo.existsByCourseIdAndOrderIndexAndDeletedAtIsNull(courseId, newOrderIndex);
        if (exists) {
            throw new IllegalArgumentException("orderIndex already exists in this course");
        }

        lesson.setOrderIndex(newOrderIndex);
    }

    private void updateTitleIfNeeded(VideoLesson lesson, String title) {
        if (title != null && !title.isBlank()) {
            lesson.setTitle(title);
        }
    }

    private void updateFreePreviewIfNeeded(VideoLesson lesson, Boolean freePreview) {
        if (freePreview != null) {
            lesson.setFreePreview(freePreview);
        }
    }

    // =========================================================
    // DELETE
    // =========================================================
    @Transactional
    public void delete(VideoLesson lesson) {
        repo.delete(lesson);
    }

    // =========================================================
    // UTIL
    // =========================================================
    public static String extractYouTubeId(String key) {
        if (key != null && key.startsWith("yt:")) {
            return key.substring(3);
        }
        throw new IllegalArgumentException("Not a YouTube key: " + key);
    }
}
