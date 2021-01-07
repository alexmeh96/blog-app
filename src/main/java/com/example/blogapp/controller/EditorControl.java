package com.example.blogapp.controller;

import com.example.blogapp.model.Image;
import com.example.blogapp.repo.ImageRepo;
import com.google.common.collect.ImmutableMap;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

@Controller
@RequestMapping("/editor")
public class EditorControl {
    @Autowired
    private ImageRepo imageRepo;

    @GetMapping
    public String ImagePage() {
        return "editor/index";
    }

    @PostMapping("/image")
    @ResponseBody
    private Map<String, String> loadImage(HttpServletRequest request, @RequestParam("file") MultipartFile file) throws IOException {
        System.out.println("!!!!!!!!!!!!!!!!!!!!!!");
        Byte[] bytes = new Byte[file.getBytes().length];
        int i = 0;
        for (byte b: file.getBytes())
            bytes[i++] = b;
        Long id = imageRepo.save(new Image(bytes)).getId();
        return ImmutableMap.of(
                "link",
                String.format("/image/%s", id));
    }

}
