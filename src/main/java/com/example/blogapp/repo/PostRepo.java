package com.example.blogapp.repo;

import com.example.blogapp.model.Post;
import com.example.blogapp.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PostRepo extends JpaRepository<Post, Long> {
    List<Post> findAllByAuthor_SubscribersContaining(User user);
    List<Post> findAllByAuthor_Id(Long id);
}
