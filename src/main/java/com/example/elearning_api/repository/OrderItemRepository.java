package com.example.elearning_api.repository;

import com.example.elearning_api.entity.OrderItem;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {
    List<OrderItem> findByCourseId(Long courseId);
    
    @Modifying
    @Transactional
    @Query("DELETE FROM OrderItem oi WHERE oi.course.id = :courseId")
    void deleteByCourseId(@Param("courseId") Long courseId);
}

