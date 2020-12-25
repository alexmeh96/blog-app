package com.example.blogapp.controller;

import com.example.blogapp.model.User;
import com.example.blogapp.service.MainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;
import java.util.Map;

@Controller
public class AuthControl {


    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private MainService mainService;

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @GetMapping("/loginError")
    public String loginPage(Map<String, Object> model) {
        model.put("messageError", "Неверное имя пользователя или пароль");
        return "login";
    }

    @GetMapping("/registration")
    public String registration() {
        return "registration";
    }

    @PostMapping("/registration")
    public String addUser(@Valid User user, BindingResult bindingResult, Model model) {

        if (user.getPassword() != null && !user.getPassword().equals(user.getPassword2())) {
            model.addAttribute("messageError", "Паролли не совпадают!");
        }

        if (bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);

            return "registration";
        }

        if (!mainService.addUser(user)) {
            model.addAttribute("messageError", "Пользователь с таким именем уже существует!");
            return "registration";
        }

        return "redirect:/login";
    }
}
