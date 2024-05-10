package com.salesianos.triana.edu.globalgathering.repository.post;

import com.salesianos.triana.edu.globalgathering.dto.post.GetPostDto;
import com.salesianos.triana.edu.globalgathering.model.Event;
import com.salesianos.triana.edu.globalgathering.model.Post;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface PostRepository extends JpaRepository<Post, UUID> {
    List<Post> findAllByCreatedBy(String createdBy);
}
