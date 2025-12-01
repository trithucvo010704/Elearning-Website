package com.example.elearning_api.exception;

import org.springframework.http.*;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.Map;

@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<Map<String, String>> handleIllegalArg(IllegalArgumentException exception) {
        return ResponseEntity.badRequest().body(Map.of("code", exception.getMessage()));
    }
    
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Map<String, String>> handleValidation(MethodArgumentNotValidException exception) {
        var firstError = exception.getBindingResult().getFieldErrors().stream().findFirst();
        String errorMessage = firstError.map(error -> error.getField() + " " + error.getDefaultMessage())
                .orElse("VALIDATION_ERROR");
        return ResponseEntity.status(HttpStatus.UNPROCESSABLE_ENTITY).body(Map.of("code", errorMessage));
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<Map<String, String>> handleOthers(Exception exception) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("code", "INTERNAL_ERROR"));
    }
}
