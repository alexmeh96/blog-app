package com.example.blogapp.repo;

import com.example.blogapp.model.Profile;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProfileRepo extends JpaRepository<Profile, Long> {
    Profile findByAuthor_Id(Long author);
}
