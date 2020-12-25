package com.example.blogapp.controller;

import com.example.blogapp.dto.ProfileDto;
import com.example.blogapp.dto.UserDto;
import com.example.blogapp.model.Profile;
import com.example.blogapp.model.User;
import com.example.blogapp.service.MainService;
import com.example.blogapp.service.UserDetailsImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/profile")
public class ProfileControl {

    @Autowired
    private MainService mainService;

    @GetMapping("/{userId}")
    public String getProfile(@AuthenticationPrincipal UserDetailsImpl userDetails,
                             @PathVariable(name = "userId") User user,
                             @RequestParam(required = false) boolean updateProfileSuccess,
                             @RequestParam(required = false) boolean subscribeSuccess,

                             Model model) {
        if (updateProfileSuccess) {
            model.addAttribute("message", "Профиль был успешно обновлён!");
        } else if (subscribeSuccess) {
            model.addAttribute("message", "Вы успешно подписались!");
        }

        if (user != null) {
            Profile profile = user.getProfile();
            model.addAttribute("profile", profile);

            List<User> subscribers = user.getSubscribers();
            if (subscribers != null && !subscribers.isEmpty()) {
                model.addAttribute("subscribers", subscribers);
            }

            if (user.getSubscribers().stream().filter(sub -> sub.getId().equals(userDetails.getId())).count() >= 1) {
                model.addAttribute("isSubscribe", true);
            } else {
                model.addAttribute("isSubscribe", false);
            }

        }

        return "profile";
    }

    @GetMapping("/update")
    public String updateProfilePage(@AuthenticationPrincipal UserDetailsImpl userDetails, Model model) {

        Profile profile = mainService.getProfile(userDetails.getId());

        model.addAttribute("profile", profile);

        return "profileEdit";
    }

    @PostMapping("update")
    public String updateProfile(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestParam(name = "profileId") Profile profile, ProfileDto profileDto) {

        mainService.updateProfile(profile, profileDto);

        return "redirect:/profile/" + userDetails.getId() + "?updateProfileSuccess=true";
    }

    @GetMapping("/settings")
    public String settingsPage(@AuthenticationPrincipal UserDetailsImpl userDetails,
                               @RequestParam(required = false) boolean updateUsernameSuccess,
                               @RequestParam(required = false) boolean updatePasswordSuccess,
                               Model model) {
        if (updateUsernameSuccess) {
            model.addAttribute("message", "Имя пользователя было успешно изменено!");
        } else if (updatePasswordSuccess) {
            model.addAttribute("message", "Пароль был успешно изменён!");
        }

        User user = mainService.getUser(userDetails.getId());
        model.addAttribute("user", user);

        return "settings";
    }

    @PostMapping("/settings/username")
    public String updateUsername(@AuthenticationPrincipal UserDetailsImpl userDetails, String username) {

        mainService.updateUsername(userDetails.getId(), username);

        return "redirect:/profile/settings?updateUsernameSuccess=true";
    }

    @PostMapping("/settings/password")
    public String updatePassword(@AuthenticationPrincipal UserDetailsImpl userDetails, String password) {

        mainService.updatePassword(userDetails.getId(), password);

        return "redirect:/profile/settings?updatePasswordSuccess=true";
    }

    @PostMapping("/subscribe")
    public String subscribe(@AuthenticationPrincipal UserDetailsImpl userDetails,
                            @RequestParam(name = "userId", required = false) User userSubscribe
    ) {
        mainService.subscribe(userDetails.getId(), userSubscribe);
        return "redirect:/profile/" + userSubscribe.getId() + "?subscribeSuccess=true";
    }
}
