package com.example.blogapp.controller;

import com.example.blogapp.dto.CommentDto;
import com.example.blogapp.model.Comment;
import com.example.blogapp.model.Post;
import com.example.blogapp.model.User;
import com.example.blogapp.service.MainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/comment")
public class CommentControl {

    @Autowired
    private MainService mainService;

    @PostMapping("/create")
    public String createComment(CommentDto commentDto,
                                @RequestParam(name = "postId") Post post,
                                @RequestParam(name = "userId") User user) {
        mainService.addComment(commentDto, post, user);
        return "redirect:/post/read/" + post.getId() + "?commentSuccess=true";
    }
}
