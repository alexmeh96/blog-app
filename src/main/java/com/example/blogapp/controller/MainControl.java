package com.example.blogapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MainControl {

    @GetMapping("/")
    public String main() {
        return "main";
    }

    @GetMapping("/content")
    public String content() {
        return "content";
    }

    @GetMapping("/test")
    public String test() {
        return "/test/comment";
    }

    @GetMapping("/test2")
    public String test2() {
        return "/test/commento";
    }

    @GetMapping("/test3")
    public String test3() {
        return "/test/profile";
    }

    @GetMapping("/sso_test")
    public String test3(@RequestParam(required = false) String token, @RequestParam(required = false) String hmac) {
        System.out.println(token);
        System.out.println(hmac);
        return "/test/commento";
    }

}
