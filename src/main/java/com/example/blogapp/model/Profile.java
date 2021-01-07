package com.example.blogapp.model;

import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@Entity
@Table(name = "profile")
public class Profile {
    @Id
    @GeneratedValue
    private Long id;

    @OneToOne(mappedBy = "profile", cascade = CascadeType.ALL)
    private User author;

    private String email;
    private String phoneNumber;
    private Long avatarId;

    public Profile() {
        this.email = "";
        this.phoneNumber = "";
        this.avatarId = 0L;
    }
}
