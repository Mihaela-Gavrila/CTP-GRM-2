package ro.ctp.grm.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "*")
public class AuthController {
    
    @GetMapping("/test")
    public ResponseEntity<?> test() {
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "Auth API is working!");
        response.put("status", "OK");
        return ResponseEntity.ok(response);
    }
    
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> request) {
        String username = request.get("username");
        String password = request.get("password");
        
        Map<String, Object> response = new HashMap<>();
        if ("admin".equals(username) && "Admin123!".equals(password)) {
            response.put("success", true);
            response.put("message", "Login successful");
            response.put("token", "fake-jwt-token-123");
            response.put("user", Map.of("username", "admin", "name", "Administrator"));
        } else {
            response.put("success", false);
            response.put("message", "Invalid credentials");
        }
        
        return ResponseEntity.ok(response);
    }
}