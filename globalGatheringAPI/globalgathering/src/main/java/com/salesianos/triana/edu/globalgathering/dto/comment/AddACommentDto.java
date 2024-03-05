package com.salesianos.triana.edu.globalgathering.dto.comment;

import java.util.UUID;

public record AddACommentDto (

    String username,

    String content,

    UUID relatedPost
){

}
