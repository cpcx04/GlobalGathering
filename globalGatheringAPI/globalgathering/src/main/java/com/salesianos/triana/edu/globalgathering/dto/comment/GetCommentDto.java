package com.salesianos.triana.edu.globalgathering.dto.comment;

import com.salesianos.triana.edu.globalgathering.model.Comments;

public record GetCommentDto (

        String comentario
){
    public static GetCommentDto of (Comments comments){
        return new GetCommentDto(
                comments.getContent()
        );
    }
}
