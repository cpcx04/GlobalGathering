package com.salesianos.triana.edu.globalgathering.service.post;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.salesianos.triana.edu.globalgathering.dto.post.GetPostDto;
import com.salesianos.triana.edu.globalgathering.dto.post.NewPostDto;
import com.salesianos.triana.edu.globalgathering.dto.post.PostResponse;
import com.salesianos.triana.edu.globalgathering.model.Event;
import com.salesianos.triana.edu.globalgathering.model.Post;
import com.salesianos.triana.edu.globalgathering.repository.event.EventRepository;
import com.salesianos.triana.edu.globalgathering.repository.post.PostRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PostService {

    private final PostRepository postRepository;
    private final EventRepository eventRepository;
    private final ObjectMapper mapper;


    public Post newPost(NewPostDto postDto, PostResponse postResponse){
        Optional<Event> e = Optional.ofNullable(eventRepository.findById(postDto.relatedEvent()).orElseThrow(() -> new EntityNotFoundException("Event with id" + postDto.relatedEvent() + " not found")));
        Post p = new Post();
        p.setComment(postDto.comment());
        p.setRelatedEvent(e.get());
        p.setUri(postResponse.getUri());
        p.setCreatedBy(postResponse.getCreatedBy());
        p.setCreatedAt(LocalDateTime.now());

        return postRepository.save(p);

    }
    public void deletePostById(UUID postId, String username) {
        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new EntityNotFoundException("Post with id " + postId + " not found"));
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        boolean isAdmin = authentication.getAuthorities().stream()
                .anyMatch(grantedAuthority -> grantedAuthority.getAuthority().equals("ROLE_ADMIN"));
        if (!post.getCreatedBy().equals(username) && !isAdmin) {
            throw new AccessDeniedException("You are not authorized to delete this post");
        }

        postRepository.deleteById(postId);
    }
    public Post newPost(String post, PostResponse postResponse) {
        NewPostDto newPostDto = null;
        try {
            newPostDto = mapper.readValue(post, NewPostDto.class);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
        return newPost(newPostDto, postResponse);
    }
    public List<GetPostDto> findAllByCreatedBy(String createdBy) {
        List<Post> posts = postRepository.findAllByCreatedBy(createdBy);
        return posts.stream()
                .map(this::mapToGetPostDto)
                .collect(Collectors.toList());
    }
    public List<GetPostDto> findAll() {
        List<Post> posts = postRepository.findAll();
        return posts.stream()
                .map(this::mapToGetPostDto)
                .collect(Collectors.toList());
    }

    private GetPostDto mapToGetPostDto(Post post) {
        return GetPostDto.of(
                post
        );
    }


}
