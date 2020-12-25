package com.example.blogapp.service;

import com.example.blogapp.dto.CommentDto;
import com.example.blogapp.dto.PostDto;
import com.example.blogapp.dto.ProfileDto;
import com.example.blogapp.dto.UserDto;
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
import java.util.Set;
import java.util.stream.Collectors;

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

    public void addComment(CommentDto commentDto, Post post, User user) {
        Comment comment = new Comment();
        comment.setDate(new Date());
        comment.setText(commentDto.getText());
        comment.setPost(post);
        comment.setAuthor(user);
        commentRepo.save(comment);
    }

    public Profile getProfile(Long userId) {
        return profileRepo.findByAuthor_Id(userId);
    }

    public User getUser(Long id) {
        return userRepo.findById(id).orElse(null);
    }

    public void updateUsername(Long id, String username) {
        User user = userRepo.findById(id).orElse(null);
        user.setUsername(username);
        userRepo.save(user);

    }

    public void updatePassword(Long id, String password) {
        User user = userRepo.findById(id).orElse(null);
        user.setPassword(passwordEncoder.encode(password));
        userRepo.save(user);
    }

    public List<User> allUser() {
        return userRepo.findAll();
    }

    public void updateUserRole(User user, List<String> roleList) {
        if (roleList == null) {
            user.getRoles().clear();
        } else {
            Set<Role> roles = roleList.stream().map(Role::valueOf).collect(Collectors.toSet());
            user.setRoles(roles);
        }
        userRepo.save(user);
    }

    public void subscribe(Long id, User userSubscribe) {
        User user = userRepo.findById(id).orElse(null);
        user.getSubscriptions().add(userSubscribe);
//        userSubscribe.getSubscribers().add(user);
        userRepo.save(user);
    }

    public List<User> getSubscribes(Long id) {
        User user = userRepo.findById(id).orElse(null);
        return user.getSubscriptions();

    }

    public List<Post> getSubscribesPost(Long id) {
        User user = userRepo.findById(id).orElse(null);
        return postRepo.findAllByAuthor_SubscribersContaining(user);
    }
}
