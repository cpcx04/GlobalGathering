package com.salesianos.triana.edu.globalgathering.dto.post;

import com.salesianos.triana.edu.globalgathering.dto.event.GetEventDto;
import com.salesianos.triana.edu.globalgathering.model.Event;
import com.salesianos.triana.edu.globalgathering.model.Post;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

public record GetPostDto (

        UUID uuid,

        String comment,
        String relatedEvent,
        PostResponse image,
        String createdBy,

        LocalDateTime createdAt
) {

    public static GetPostDto of (Post post,PostResponse response){
        return new GetPostDto(
             post.getId(),
                post.getComment(),
                post.getRelatedEvent().getId().toString(),
                response,
                post.getCreatedBy(),
                post.getCreatedAt()

        );
    }


}
