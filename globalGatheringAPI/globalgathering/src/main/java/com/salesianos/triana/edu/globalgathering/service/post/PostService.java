package com.salesianos.triana.edu.globalgathering.service.post;


import com.salesianos.triana.edu.globalgathering.dto.post.GetPostDto;
import com.salesianos.triana.edu.globalgathering.dto.post.NewPostDto;
import com.salesianos.triana.edu.globalgathering.dto.post.PostResponse;
import com.salesianos.triana.edu.globalgathering.model.Event;
import com.salesianos.triana.edu.globalgathering.model.Post;
import com.salesianos.triana.edu.globalgathering.repository.event.EventRepository;
import com.salesianos.triana.edu.globalgathering.repository.post.PostRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PostService {

    private final PostRepository postRepository;
    private final EventRepository eventRepository;


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
    public List<GetPostDto> findAllByCreatedBy(String createdBy) {
        List<Post> posts = postRepository.findAllByCreatedBy(createdBy);
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
