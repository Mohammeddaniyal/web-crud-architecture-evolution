package com.thinking.machines.hr.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginController {
    @GetMapping("/login")
    public String showLoginPage() {
        // "forward:" tells Spring to serve the physical file
        // without changing the URL in the browser's address bar!
        return "forward:/login.html";
    }
}
