package com.example.blogapp.dto;

import lombok.Data;

import javax.validation.constraints.Email;

@Data
public class UserDto {

    private String username;
    private String password;
    private String password2;
}
