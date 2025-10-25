package com.example.elearning_api.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import java.util.ArrayList;
import java.util.List;

@Configuration
@ConfigurationProperties(prefix = "app.video")
@Data
public class VideoProps {
    public enum Provider { MANUAL, YOUTUBE }
    private Provider provider = Provider.MANUAL;
    private List<String> allowedOrigins = new ArrayList<>();
}
