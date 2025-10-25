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

    @Transactional
    public VideoLesson createAfterUpload(Course c, String title, int orderIndex,
            boolean freePreview, Integer durationSec, String youtubeVideoId) {
        if (c == null) {
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
        if (repo.existsByCourseIdAndOrderIndexAndDeletedAtIsNull(c.getId(), orderIndex)) {
            throw new IllegalArgumentException("Order index already exists in this course");
        }

        VideoLesson l = new VideoLesson();
        l.setCourse(c);
        l.setTitle(title);
        l.setOrderIndex(orderIndex);
        l.setFreePreview(freePreview);
        l.setDurationSec(durationSec);
        l.setS3Key("yt:" + youtubeVideoId); // quy ước lưu YouTube ID
        return repo.save(l);
    }

    public List<VideoLesson> listByCourse(Long courseId) {
        if (courseId == null) {
            throw new IllegalArgumentException("Course ID cannot be null");
        }
        return repo.findByCourseIdAndDeletedAtIsNullOrderByOrderIndexAsc(courseId);
    }

    public VideoLesson getInCourseOrThrow(Long courseId, Long lessonId) {
        if (courseId == null) {
            throw new IllegalArgumentException("Course ID cannot be null");
        }
        if (lessonId == null) {
            throw new IllegalArgumentException("Lesson ID cannot be null");
        }
        return repo.findByIdAndCourseIdAndDeletedAtIsNull(lessonId, courseId)
                .orElseThrow(() -> new IllegalArgumentException("Lesson not found"));
    }

    @Transactional
    public VideoLesson updateMeta(VideoLesson l, String title, Integer orderIndex, Boolean freePreview) {
        if (orderIndex != null && !orderIndex.equals(l.getOrderIndex())) {
            if (repo.existsByCourseIdAndOrderIndexAndDeletedAtIsNull(l.getCourse().getId(), orderIndex))
                throw new IllegalArgumentException("orderIndex already exists in this course");
            l.setOrderIndex(orderIndex);
        }
        if (title != null && !title.isBlank())
            l.setTitle(title);
        if (freePreview != null)
            l.setFreePreview(freePreview);
        return repo.save(l);
    }

    @Transactional
    public void delete(VideoLesson l) {
        repo.delete(l);
    }

    public static String extractYouTubeId(String key) {
        if (key != null && key.startsWith("yt:"))
            return key.substring(3);
        throw new IllegalArgumentException("Not a YouTube key: " + key);
    }
}
