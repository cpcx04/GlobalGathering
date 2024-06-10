package com.salesianos.triana.edu.globalgathering.dto.post;

import java.util.UUID;

public record NewPostDto(

        UUID relatedEvent,

        String comment
) {

}
