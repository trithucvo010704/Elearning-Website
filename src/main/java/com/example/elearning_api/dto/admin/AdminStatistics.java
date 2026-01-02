package com.example.elearning_api.dto.admin;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AdminStatistics {
    private long totalUsers;
    private long totalCourses;
    private long totalInstructors;
    private long totalRevenue;
    private long activeEnrollments;
    private RevenueStats revenueStats;

    @Data
    @Builder
    public static class RevenueStats {
        private long daily;
        private long weekly;
        private long monthly;
        private long yearly;
    }
}