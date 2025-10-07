package com.example.elearning_api.repository;

import com.example.elearning_api.entity.User;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepo  extends BaseRepo<User>{
    boolean existsByUsername(String username);
    Optional<User> findByUsername(String username);
}
