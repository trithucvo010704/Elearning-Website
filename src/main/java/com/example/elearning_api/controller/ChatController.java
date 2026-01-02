package com.example.elearning_api.controller;

import com.example.elearning_api.dto.chat.ChatRequest;
import com.example.elearning_api.dto.chat.ChatResponse;
import com.example.elearning_api.service.ChatService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/chat")
@RequiredArgsConstructor
public class ChatController {

    private final ChatService chatService;

    @PostMapping("/ask")
    public ResponseEntity<ChatResponse> ask(@RequestBody ChatRequest request) {
        String reply = chatService.getChatResponse(request.getMessage());
        return ResponseEntity.ok(new ChatResponse(reply));
    }
}
