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
                // TODO: Optional - verify user là instructor của courseId (nếu có bảng
                // course_instructors)

                var course = courseRepo.findByIdAndDeletedAtIsNull(courseId)
                                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND,
                                                "Course not found"));

                var l = new VideoLesson();
                l.setCourse(course);
                l.setTitle(req.title());
                l.setOrderIndex(req.orderIndex());
                l.setDurationSec(req.durationSec());
                l.setFreePreview(req.freePreview());
                l.setS3Key("yt:" + req.youtubeVideoId());
                l.setCreatedAt(LocalDateTime.now());

                var saved = lessonRepo.save(l);
                var body = new LessonItem(saved.getId(), saved.getTitle(),
                                saved.getDurationSec(), saved.isFreePreview(), saved.getOrderIndex());
                return ResponseEntity.status(HttpStatus.CREATED).body(body);
        }

        /** Playlist bên phải (giống UI THAKI: tiêu đề + thời lượng + order). */
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
                var l = lessonRepo.findByIdAndCourseIdAndDeletedAtIsNull(lessonId, courseId)
                                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND,
                                                "Lesson not found"));
                boolean allow = gating.canWatch(me, l);
                if (!allow)
                        return new EmbedResponse(false, "youtube", null, null);

                String vid = youtube.extractVideoId(l.getS3Key());
                String url = youtube.buildEmbedUrl(l.getS3Key(), origin);
                return new EmbedResponse(true, "youtube", vid, url);
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
