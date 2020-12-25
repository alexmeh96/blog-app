package com.example.blogapp.controller;

import com.example.blogapp.model.Role;
import com.example.blogapp.model.User;
import com.example.blogapp.service.MainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminControl {

    @Autowired
    private MainService mainService;

    @GetMapping
    @PreAuthorize("hasAuthority('ADMIN')")
    public String adminPage() {
        return "admin";
    }

    @GetMapping("/userList")
    @PreAuthorize("hasAuthority('ADMIN')")
    public String userList(@RequestParam(required = false) boolean delete,
                           @RequestParam(required = false) boolean update,
                           Model model) {
        if (delete) {
            model.addAttribute("message", "Вы удалили пользователя");
        } else if (update) {
            model.addAttribute("message", "Вы обновили пользователя");
        }
        List<User> userList = mainService.allUser();
        model.addAttribute("users", userList);
        return "userList";
    }

    @GetMapping("/user/{userId}")
    @PreAuthorize("hasAuthority('ADMIN')")
    public String userId(@PathVariable(name = "userId") User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "userId";
    }


    @PostMapping("/user/update")
    @PreAuthorize("hasAuthority('ADMIN')")
    public String updateUser(@RequestParam(name = "userId") User user, @RequestParam(required = false) List<String> roleList) {

        mainService.updateUserRole(user, roleList);
        return "redirect:/admin/userList?update=true";
    }
}
