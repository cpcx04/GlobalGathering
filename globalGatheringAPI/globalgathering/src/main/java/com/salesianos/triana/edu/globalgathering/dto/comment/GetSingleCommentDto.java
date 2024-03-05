package com.salesianos.triana.edu.globalgathering.dto.comment;

import com.salesianos.triana.edu.globalgathering.model.Comments;

import java.util.UUID;

public record GetSingleCommentDto(

    UUID uuid,
    String avatar,
    String username,
    String content
){

    public static GetSingleCommentDto of (Comments comments){
        return new GetSingleCommentDto(
                comments.getId(),
                comments.getPostedBy().getAvatar(),
                comments.getPostedBy().getUsername(),
                comments.getContent()
        );
    }

}
