package com.salesianos.triana.edu.globalgathering.dto.comment;

import com.salesianos.triana.edu.globalgathering.model.Comments;

public record GetSingleCommentDto(

    String avatar,
    String username,
    String content
){

    public static GetSingleCommentDto of (Comments comments){
        return new GetSingleCommentDto(
                comments.getPostedBy().getAvatar(),
                comments.getPostedBy().getUsername(),
                comments.getContent()
        );
    }

}
