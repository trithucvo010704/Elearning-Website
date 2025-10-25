package com.example.elearning_api.repository;

import com.example.elearning_api.Enum.Role;
import com.example.elearning_api.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    List<User> findByRole(Role role);

    long countByRole(Role role);

    // Thêm các method cần thiết cho authentication
    Optional<User> findByUsername(String username);

    boolean existsByUsername(String username);
}