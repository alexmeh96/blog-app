package com.example.blogapp.model;

import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@Entity
@NoArgsConstructor
@Table(name = "images")
public class Image {
    @Id
    @GeneratedValue
    private Long id;

    @Lob
    private Byte[] image;

    public Image(Byte[] image) {
        this.image = image;
    }
}
