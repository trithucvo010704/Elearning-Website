package com.example.elearning_api.entity;

import com.example.elearning_api.Enum.InstructorRole;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "course_instructors",
        uniqueConstraints = @UniqueConstraint(columnNames = {"course_id","user_id"}))
public class CourseInstructor extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY) @JoinColumn(name="course_id", nullable=false)
    private Course course;

    @ManyToOne(fetch = FetchType.LAZY) @JoinColumn(name="user_id", nullable=false)
    private User user;

    @Enumerated(EnumType.STRING)
    @Column(name="role", length=16, nullable=false)
    private InstructorRole role = InstructorRole.OWNER;
}
