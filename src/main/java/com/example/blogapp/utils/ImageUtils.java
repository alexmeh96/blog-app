package com.example.blogapp.utils;

import com.example.blogapp.model.Image;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;

public class ImageUtils {
    public static Image loadImage(MultipartFile file) throws IOException {
        Byte[] bytes = new Byte[file.getBytes().length];
        int i = 0;
        for (byte b: file.getBytes())
            bytes[i++] = b;
        return new Image(bytes);
    }

    public static Image loadImageStream(InputStream inputStream) throws IOException {
        Byte[] bytes = new Byte[inputStream.available()];
        int i = 0;
        for (byte b: inputStream.readAllBytes())
            bytes[i++] = b;
        return new Image(bytes);
    }
}
