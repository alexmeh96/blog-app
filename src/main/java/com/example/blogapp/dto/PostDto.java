package com.example.blogapp.dto;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class PostDto {
    private String name;
    private String text;
    private String describe;
    private MultipartFile file;
    private Boolean changeImage;
}
