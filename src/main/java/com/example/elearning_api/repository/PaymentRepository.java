package com.example.elearning_api.repository;

import com.example.elearning_api.entity.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface PaymentRepository extends JpaRepository<Payment, Long> {
    List<Payment> findByCreatedAtAfter(LocalDateTime date);

    @Query("SELECT COALESCE(SUM(p.amountCents), 0) FROM Payment p")
    long sumTotalAmount();

    @Query("SELECT COALESCE(SUM(p.amountCents), 0) FROM Payment p WHERE p.createdAt >= :date")
    long sumAmountAfter(@Param("date") LocalDateTime date);
}