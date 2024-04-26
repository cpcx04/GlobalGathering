package com.salesianos.triana.edu.globalgathering.dto.comment;

import com.salesianos.triana.edu.globalgathering.model.ClientWorker;

import java.util.List;
import java.util.stream.Collectors;

public record GetAllComents(

        String username,

        List<GetCommentDto>comentarios

) {

    public static GetAllComents of (ClientWorker c){
        return new GetAllComents(
                c.getUsername(),
                c.getComments().stream()
                        .map(GetCommentDto::of)
                        .collect(Collectors.toList())
        );

    }

}
