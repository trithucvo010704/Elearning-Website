package com.example.elearning_api.controller;

import com.example.elearning_api.dto.lesson.CreateLessonManualRequest;
import com.example.elearning_api.dto.lesson.EmbedResponse;
import com.example.elearning_api.dto.lesson.LessonItem;
import com.example.elearning_api.entity.VideoLesson;
import com.example.elearning_api.repository.CourseRepository;
import com.example.elearning_api.repository.VideoLessonRepo;
import com.example.elearning_api.service.GatingService;
import com.example.elearning_api.service.YoutubeProvider;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import com.example.elearning_api.security.UserPrincipal;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("api")
@RequiredArgsConstructor
public class LessonController {
        private final VideoLessonRepo lessonRepo;
        private final CourseRepository courseRepo;
        private final YoutubeProvider youtube;
        private final GatingService gating;

        /**
         * Instructor thêm bài học bằng YouTube ID (manual).
         * Lưu providerKey = "yt:{videoId}" (đúng quy ước trong plan).
         */
        @PreAuthorize("hasAnyRole('ADMIN','INSTRUCTOR')")
        @PostMapping("/courses/{courseId}/lessons/manual")
        public ResponseEntity<LessonItem> createManual(
                @PathVariable Long courseId,
                @Valid @RequestBody CreateLessonManualRequest req,
                @AuthenticationPrincipal UserPrincipal me) {

                // Kiểm tra course tồn tại
                var course = courseRepo.findByIdAndDeletedAtIsNull(courseId)
                        .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Course not found"));

                // (Tùy chọn) Kiểm tra instructor có quyền dạy course này
                // if (!courseService.isInstructorOf(courseId, me.getId())) {
                //     throw new ResponseStatusException(HttpStatus.FORBIDDEN, "You are not instructor of this course");
                // }

                // Kiểm tra dữ liệu đầu vào
                if (req.youtubeVideoId() == null || req.youtubeVideoId().isBlank()) {
                        throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "YouTube video ID is required");
                }
                if (req.orderIndex() == null || req.orderIndex() < 0) {
                        throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Invalid order index");
                }
                if (req.durationSec() == null || req.durationSec() < 0) {
                        throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Invalid video duration");
                }

                // Kiểm tra trùng orderIndex trong course
                boolean existsOrder = lessonRepo.existsByCourseIdAndOrderIndexAndDeletedAtIsNull(courseId, req.orderIndex());
                if (existsOrder) {
                        throw new ResponseStatusException(HttpStatus.CONFLICT, "Lesson order already exists");
                }

                // Tạo lesson
                var lesson = new VideoLesson();
                lesson.setCourse(course);
                lesson.setTitle(req.title());
                lesson.setOrderIndex(req.orderIndex());
                lesson.setDurationSec(req.durationSec());
                lesson.setFreePreview(Boolean.TRUE.equals(req.freePreview()));
                lesson.setS3Key("yt:" + req.youtubeVideoId().trim());
                lesson.setCreatedAt(LocalDateTime.now());

                try {
                        var saved = lessonRepo.save(lesson);
                        var body = new LessonItem(
                                saved.getId(),
                                saved.getTitle(),
                                saved.getDurationSec(),
                                saved.isFreePreview(),
                                saved.getOrderIndex()
                        );
                        return ResponseEntity.status(HttpStatus.CREATED).body(body);
                } catch (Exception e) {
                        throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Failed to create lesson", e);
                }
        }

        /** Playlist bên phải (tiêu đề + thời lượng + order). */
        @GetMapping("/courses/{courseId}/lessons")
        public List<LessonItem> listLessons(@PathVariable Long courseId) {
                return lessonRepo.findByCourseIdAndDeletedAtIsNullOrderByOrderIndexAsc(courseId)
                                .stream()
                                .map(l -> new LessonItem(l.getId(), l.getTitle(),
                                                l.getDurationSec(), l.isFreePreview(), l.getOrderIndex()))
                                .toList();
        }

        /**
         * Delete a lesson
         */
        @PreAuthorize("hasAnyRole('ADMIN','INSTRUCTOR')")
        @DeleteMapping("/lessons/{lessonId}")
        @ResponseStatus(HttpStatus.NO_CONTENT)
        public void deleteLesson(@PathVariable Long lessonId) {
                var lesson = lessonRepo.findById(lessonId)
                                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND,
                                                "Lesson not found"));
                lesson.setDeletedAt(LocalDateTime.now());
                lessonRepo.save(lesson);
        }

        /**
         * FE hỏi thông tin nhúng player.
         * Nếu không đủ quyền -> canWatch=false, FE ẩn iframe & hiện paywall.
         */
        @GetMapping("/lessons/{lessonId}/embed")
        public EmbedResponse getEmbed(
                @PathVariable Long lessonId,
                @RequestParam Long courseId,
                @RequestParam String origin,
                @AuthenticationPrincipal UserPrincipal me) {

                var lesson = lessonRepo.findByIdAndCourseIdAndDeletedAtIsNull(lessonId, courseId)
                        .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Lesson not found"));

                // Kiểm tra quyền truy cập
                if (!gating.canWatch(me, lesson)) {
                        return new EmbedResponse(false, "youtube", null, null);
                }

                // Kiểm tra S3Key hợp lệ
                String s3Key = lesson.getS3Key();
                if (s3Key == null || s3Key.isBlank()) {
                        throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Invalid video source");
                }

                // Xử lý YouTube link an toàn
                String videoId;
                String embedUrl;
                try {
                        videoId = youtube.extractVideoId(s3Key);
                        embedUrl = youtube.buildEmbedUrl(s3Key, origin);
                } catch (Exception e) {
                        throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Failed to build embed URL", e);
                }

                return new EmbedResponse(true, "youtube", videoId, embedUrl);
        }

        /**
         * Instructor preview - luôn cho phép instructor xem preview
         */
        @PreAuthorize("hasAnyRole('ADMIN','INSTRUCTOR')")
        @GetMapping("/lessons/{lessonId}/preview")
        public EmbedResponse getPreview(
                        @PathVariable Long lessonId,
                        @RequestParam Long courseId,
                        @RequestParam String origin,
                        @AuthenticationPrincipal UserPrincipal me) {
                var l = lessonRepo.findByIdAndCourseIdAndDeletedAtIsNull(lessonId, courseId)
                                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND,
                                                "Lesson not found"));

                String vid = youtube.extractVideoId(l.getS3Key());
                String url = youtube.buildEmbedUrl(l.getS3Key(), origin);
                return new EmbedResponse(true, "youtube", vid, url);
        }
}
