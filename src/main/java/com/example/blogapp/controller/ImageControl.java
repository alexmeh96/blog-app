package com.example.blogapp.controller;

import com.example.blogapp.model.Image;
import com.example.blogapp.repo.ImageRepo;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

//@Controller
//@RequestMapping("/image")
//public class ImageControl {
//    @Autowired
//    private ImageRepo imageRepo;
//
//    @GetMapping
//    public String ImagePage() {
//        return "image";
//    }
//
//    @PostMapping
//    private String loadImage(@RequestParam("file") MultipartFile file) throws IOException {
//        Byte[] bytes = new Byte[file.getBytes().length];
//        int i = 0;
//        for (byte b: file.getBytes())
//            bytes[i++] = b;
//        imageRepo.save(new Image(bytes));
//        return "redirect:/image";
//    }
//
//    @GetMapping("/{id}")
//    public void renderImage(@PathVariable("id") String id, HttpServletResponse response) throws IOException {
//        response.setContentType("image/jpeg");
//        Image image = imageRepo.findById(Long.valueOf(id)).orElse(null);
//        if (image == null) {
//            return;
//        }
//        byte[] bytes = new byte[image.getImage().length];
//        int i = 0;
//        for (byte b: image.getImage())
//            bytes[i++] = b;
//        InputStream is = new ByteArrayInputStream(bytes);
//        IOUtils.copy(is, response.getOutputStream());
//    }
//}
