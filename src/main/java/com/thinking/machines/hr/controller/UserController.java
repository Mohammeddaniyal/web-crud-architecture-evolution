package com.thinking.machines.hr.controller;

import com.thinking.machines.hr.dto.UserDTO;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/auth")
public class UserController {
    @GetMapping("/me")
    public ResponseEntity<UserDTO> getCurrentUser()
    {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String role=authentication.getAuthorities().iterator().next().getAuthority();
        UserDTO userDTO =new UserDTO(authentication.getName(),role);
        return ResponseEntity.ok(userDTO);
    }
}
