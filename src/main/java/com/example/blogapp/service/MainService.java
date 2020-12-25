package com.example.blogapp.service;

import com.example.blogapp.dto.PostDto;
import com.example.blogapp.dto.ProfileDto;
import com.example.blogapp.model.*;
import com.example.blogapp.repo.CommentRepo;
import com.example.blogapp.repo.PostRepo;
import com.example.blogapp.repo.ProfileRepo;
import com.example.blogapp.repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.Date;
import java.util.List;

@Service
public class MainService {
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private PostRepo postRepo;
    @Autowired
    private ProfileRepo profileRepo;
    @Autowired
    private CommentRepo commentRepo;
    @Autowired
    private PasswordEncoder passwordEncoder;


    public long countUser() {
        return userRepo.count();
    }

    public void createFirstUser(User user) {
        Profile profile = new Profile();

        user.setProfile(profile);
        profile.setAuthor(user);
        userRepo.save(user);
    }

    public boolean addUser(User newUser) {
        User user = userRepo.findByUsername(newUser.getUsername()).orElse(null);

        if (user != null) {
            return false;
        }

        newUser.setPassword(passwordEncoder.encode(newUser.getPassword()));
        newUser.setRoles(Collections.singleton(Role.USER));

        Profile profile = new Profile();

        newUser.setProfile(profile);
        profile.setAuthor(newUser);

        userRepo.save(newUser);
        return true;
    }

    public List<Post> allPost() {
        return postRepo.findAll();
    }

    public void addPost(PostDto postDto, Long userId) {
        User user = userRepo.findById(userId).orElse(null);
        Post post = new Post();
        post.setText(postDto.getText());
        post.setName(postDto.getName());
        post.setDate(new Date());

        post.setAuthor(user);
        postRepo.save(post);
    }

    public void updatePost(Post post, PostDto postDto) {
        post.setName(postDto.getName());
        post.setText(postDto.getText());

        postRepo.save(post);
    }

    public void delete(Long postId) {
        postRepo.deleteById(postId);
    }

    public void updateProfile(Profile profile, ProfileDto profileDto) {
        profile.setEmail(profileDto.getEmail());
        profile.setPhoneNumber(profileDto.getPhoneNumber());
        profileRepo.save(profile);
    }

    public void addComment(Comment comment) {
        commentRepo.save(comment);
    }

    public Profile getProfile(Long userId) {
        return profileRepo.findByAuthor_Id(userId);
    }
}
