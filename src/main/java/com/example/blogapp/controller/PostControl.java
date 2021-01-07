package com.example.blogapp.controller;

import com.example.blogapp.dto.PostDto;
import com.example.blogapp.model.Comment;
import com.example.blogapp.model.Post;
import com.example.blogapp.model.User;
import com.example.blogapp.service.MainService;
import com.example.blogapp.service.UserDetailsImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/post")
public class PostControl {
    @Autowired
    private MainService mainService;

    @GetMapping("/all")
    public String allPost(@RequestParam(required = false) boolean addSuccess,
                          @RequestParam(required = false) boolean updateSuccess,
                          @RequestParam(required = false) boolean deleteSuccess,
                          Model model) {

        if (addSuccess) {
            model.addAttribute("message", "Пост успешно создан!");
        } else if (updateSuccess) {
            model.addAttribute("message", "Пост успешно изменён!");
        } else if (deleteSuccess) {
            model.addAttribute("message", "Пост успешно удалён!");
        }

        List<Post> postList = mainService.allPost();
        if (postList != null && !postList.isEmpty()) {
            model.addAttribute("posts", postList);
        }
        model.addAttribute("allPosts", true);

        return "postList";
    }

    @GetMapping("/{userId}")
    public String userPost(@AuthenticationPrincipal UserDetailsImpl userDetails, @PathVariable(name = "userId") User user, Model model) {
        List<Post> postList = mainService.getUserPost(user);

        if (postList != null && !postList.isEmpty()) {
            model.addAttribute("posts", postList);
        }

        if (!userDetails.getId().equals(user.getId())) {
            model.addAttribute("auth", user);
        }

        return "postList";
    }

    @GetMapping("/create")
    public String createPostPage(Model model) {
        model.addAttribute("isCreate", true);
        return "post";
    }

    @PostMapping("/create")
    public String createPost(@AuthenticationPrincipal UserDetailsImpl userDetails, PostDto postDto) {
        mainService.addPost(postDto, userDetails.getId());
        return "redirect:/post/all?addSuccess=true";
    }

    @GetMapping("/update/{postId}")
    public String updatePostPage(@PathVariable(name = "postId") Post post, Model model) {
        model.addAttribute("isCreate", false);

        if (post != null) {
            model.addAttribute("post", post);
        }
        return "post";
    }

    @PostMapping("/update")
    public String updatePost(@RequestParam(name = "postId") Post post, PostDto postDto) {
        mainService.updatePost(post, postDto);
        return "redirect:/post/all?updateSuccess=true";
    }

    @PostMapping("/delete")
    public String deletePost(Long postId) {
        mainService.delete(postId);
        return "redirect:/post/all?deleteSuccess=true";
    }

    @GetMapping("/read/{postId}")
    public String readPostPage(@PathVariable(name = "postId") Post post,
                               @RequestParam(required = false) boolean commentSuccess,
                               Model model) {
        model.addAttribute("isCreate", false);

        if (commentSuccess) {
            model.addAttribute("message", "Комментарий успешно добавлен!");
        }

        if (post != null) {
            model.addAttribute("post", post);

            List<Comment> commentList = post.getComments();
            if (commentList != null && !commentList.isEmpty()) {
                model.addAttribute("comments", commentList);
            }
        }
        return "postId";
    }

    @GetMapping("/subscribe")
    public String subscribePage(@AuthenticationPrincipal UserDetailsImpl userDetails, Model model) {

        List<User> subscribes = mainService.getSubscribes(userDetails.getId());
        if (subscribes != null && !subscribes.isEmpty()) {
            model.addAttribute("subscribes", subscribes);
        }

        List<Post> postList = mainService.getSubscribesPost(userDetails.getId());

        if (postList != null && !postList.isEmpty()) {
            model.addAttribute("posts", postList);
        }
        return "subscribe";
    }

}
