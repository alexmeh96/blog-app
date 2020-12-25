package com.example.blogapp.controller;

import com.example.blogapp.dto.ProfileDto;
import com.example.blogapp.model.Profile;
import com.example.blogapp.model.User;
import com.example.blogapp.service.MainService;
import com.example.blogapp.service.UserDetailsImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/profile")
public class ProfileControl {

    @Autowired
    private MainService mainService;

    @GetMapping("/{userId}")
    private String getProfile(@PathVariable(name = "userId") User user,
                              @RequestParam(required = false) boolean updateProfileSuccess,
                              Model model) {
        if (updateProfileSuccess) {
            model.addAttribute("message", "Профиль был успешно обновлён!");
        }
        if (user != null) {
            Profile profile = user.getProfile();
            model.addAttribute("profile", profile);
        }

        return "profile";
    }

    @GetMapping("/update")
    private String updateProfilePage(@AuthenticationPrincipal UserDetailsImpl userDetails, Model model) {

        Profile profile = mainService.getProfile(userDetails.getId());

        model.addAttribute("profile", profile);

        return "profileEdit";
    }

    @PostMapping("update")
    private String updateProfile(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestParam(name = "profileId") Profile profile, ProfileDto profileDto) {

        mainService.updateProfile(profile, profileDto);

        return "redirect:/profile/" + userDetails.getId() + "?updateProfileSuccess=true";

    }
}
