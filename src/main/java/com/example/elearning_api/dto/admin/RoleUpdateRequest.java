package com.example.elearning_api.dto.admin;

import com.example.elearning_api.Enum.Role;
import lombok.Data;

@Data
public class RoleUpdateRequest {
    private Role role;
}