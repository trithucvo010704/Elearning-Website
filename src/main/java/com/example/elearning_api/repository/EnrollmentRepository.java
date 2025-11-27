package com.example.elearning_api.repository;

import com.example.elearning_api.entity.Course;
import com.example.elearning_api.entity.Enrollment;
import com.example.elearning_api.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface EnrollmentRepository extends JpaRepository<Enrollment, Long> {
    @Query("SELECT COUNT(e) FROM Enrollment e WHERE e.status = 'ACTIVE'")
    long countActive();

    Enrollment findByUserAndCourse(User user, Course course);
}