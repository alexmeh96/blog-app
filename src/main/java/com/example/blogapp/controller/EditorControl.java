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
public class EditorControl {
    @Autowired
    private ImageRepo imageRepo;



    @GetMapping("/editor")
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

//    @PostMapping("/image")
//    @ResponseBody
//    public Map<String, String> imageUpload(HttpServletRequest request, @RequestParam("file") MultipartFile file) {
//        System.out.println("!!!!!!!!!!!!!!!!!!!!!!");
//
//        try {
//            UploadResult result = servcie.upload(file);
//
//            log.debug("upload result : {}", result);
//
//            // {"link" : "/image/201905/e98ff4f7-93a3-4aeb-813b-12f20a03db96.jpg"}
//            return ImmutableMap.of(
//                    "link",
//                    String.format("%s/image/%s", request.getContextPath(), result.getPath()));
//
//        } catch (Exception ex) {
//            ex.printStackTrace();
//
//            return ImmutableMap.of("error", ex.getMessage());
//        }
//        return null;
//    }

    @GetMapping("/image/{id}")
    public void renderImage(@PathVariable("id") String id, HttpServletResponse response) throws IOException {
        response.setContentType("image/jpeg");
        Image image = imageRepo.findById(Long.valueOf(id)).orElse(null);
        if (image == null) {
            return;
        }
        byte[] bytes = new byte[image.getImage().length];
        int i = 0;
        for (byte b: image.getImage())
            bytes[i++] = b;
        InputStream is = new ByteArrayInputStream(bytes);
        IOUtils.copy(is, response.getOutputStream());
    }

    @PostMapping("/delete")
    private void deleteImage(@RequestParam(required = false) Long id ) throws IOException {

        imageRepo.deleteById(id);
    }

    @PostMapping("/image/save")
    private void save(@RequestParam(name = "editor_content", required = false) String text ) throws IOException {

        System.out.println(text);
    }

}
