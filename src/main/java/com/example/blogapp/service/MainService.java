package com.example.blogapp.service;

import com.example.blogapp.dto.CommentDto;
import com.example.blogapp.dto.PostDto;
import com.example.blogapp.dto.ProfileDto;
import com.example.blogapp.dto.UserDto;
import com.example.blogapp.model.*;
import com.example.blogapp.repo.*;
import com.example.blogapp.utils.ImageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.*;
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
    @Autowired
    private ImageRepo imageRepo;


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
        post.setDescribe(postDto.getDescribe());

        if (postDto.getFile() != null && !postDto.getFile().isEmpty()) {
            try {
                Image image = ImageUtils.loadImage(postDto.getFile());
                Long imageId = imageRepo.save(image).getId();
                post.setImagePreviewId(imageId);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            post.setImagePreviewId(1L);
        }

        post.setAuthor(user);
        postRepo.save(post);
    }

    public void updatePost(Post post, PostDto postDto) {
        post.setName(postDto.getName());
        post.setText(postDto.getText());
        post.setDescribe(postDto.getDescribe());
        if (postDto.getChangeImage() != null) {
            try {
                if (postDto.getFile() != null && !postDto.getFile().isEmpty()) {
                    System.out.println("qqqqqqqqqqqqqqqqqqqq");
                    if (post.getImagePreviewId()==1L) {
                        Image image = ImageUtils.loadImage(postDto.getFile());
                        Long imageId = imageRepo.save(image).getId();
                        post.setImagePreviewId(imageId);
                    } else {
                        imageRepo.deleteById(post.getImagePreviewId());
                        Image image = ImageUtils.loadImage(postDto.getFile());
                        Long imageId = imageRepo.save(image).getId();
                        post.setImagePreviewId(imageId);
                    }
                } else {
                    System.out.println("nooooo");
                    post.setImagePreviewId(1L);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
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

    @Transactional
    public List<Post> getSubscribesPost(Long id) {
        User user = userRepo.findById(id).orElse(null);
        return postRepo.findAllByAuthor_SubscribersContaining(user);
    }

    public boolean imageExist(long id) {
        return imageRepo.existsById(id);
    }

    public void addImage() {
        try {
            InputStream inputStream1 = new FileInputStream("/home/alex/work/Projects/blog-app/src/main/resources/static/img/avatar_default.png");
            InputStream inputStream2 = new FileInputStream("/home/alex/work/Projects/blog-app/src/main/resources/static/img/content_default.jpg");

            Image image1 = ImageUtils.loadImageStream(inputStream1);
            image1.setId(0L);
            Image image2 = ImageUtils.loadImageStream(inputStream2);
            image1.setId(1L);

            imageRepo.saveAll(Arrays.asList(image1, image2));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Transactional
    public List<Post> getUserPost(User user) {
        return postRepo.findAllByAuthor_Id(user.getId());
    }

    @Transactional
    public void avatarUpdate(Long userId, MultipartFile avatar) {
        Profile profile = profileRepo.findByAuthor_Id(userId);

        try {
            Image image = ImageUtils.loadImage(avatar);
            Long imageId = imageRepo.save(image).getId();
            profile.setAvatarId(imageId);
        } catch (IOException e) {
            e.printStackTrace();
        }

        profileRepo.save(profile);
    }
}
