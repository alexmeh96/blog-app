package com.example.blogapp;

import com.example.blogapp.model.Role;
import com.example.blogapp.model.User;
import com.example.blogapp.service.MainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.annotation.Transactional;

import java.util.Set;

@SpringBootApplication
public class BlogAppApplication implements CommandLineRunner {

    @Autowired
    private MainService mainService;
    @Autowired
    private PasswordEncoder passwordEncoder;


    public static void main(String[] args) {
        SpringApplication.run(BlogAppApplication.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
        if (mainService.countUser() == 0) {
            User user = new User("admin", passwordEncoder.encode("admin"), Set.of(Role.USER, Role.ADMIN));
            mainService.createFirstUser(user);
        }

        if (!mainService.imageExist(0L)) {
            mainService.addImage();
        }
    }
}
