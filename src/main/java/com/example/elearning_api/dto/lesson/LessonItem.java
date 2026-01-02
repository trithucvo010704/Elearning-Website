package com.example.elearning_api.dto.lesson;
/** Item cho playlist ở panel bên phải (title + duration + order). */
public record LessonItem(
        Long id, String title, Integer durationSec, Boolean freePreview, Integer orderIndex
) {
}
