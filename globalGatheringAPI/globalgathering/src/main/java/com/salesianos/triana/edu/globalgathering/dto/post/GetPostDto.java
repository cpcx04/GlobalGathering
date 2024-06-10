package com.salesianos.triana.edu.globalgathering.dto.post;

import com.salesianos.triana.edu.globalgathering.model.Post;

import java.time.LocalDateTime;
import java.util.UUID;

public record GetPostDto (

        UUID uuid,

        String comment,
        String relatedEvent,
        String uri,
        String createdBy,

        LocalDateTime createdAt
) {

    public static GetPostDto of (Post post){
        return new GetPostDto(
             post.getId(),
                post.getComment(),
                post.getRelatedEvent().getName(),
                post.getUri(),
                post.getCreatedBy(),
                post.getCreatedAt()

        );
    }


}
