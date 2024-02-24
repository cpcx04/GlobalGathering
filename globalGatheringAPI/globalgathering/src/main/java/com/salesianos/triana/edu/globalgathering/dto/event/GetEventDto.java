package com.salesianos.triana.edu.globalgathering.dto.event;

import com.salesianos.triana.edu.globalgathering.model.Event;

public record GetEventDto(
       String name,
       String descripcion,
       String url,
       double latitud,
       double longitud,
       double price,
       String createdBy
){
    public static GetEventDto of (Event event){
        return new GetEventDto(
                event.getName(),
                event.getDescripcion(),
                event.getUrl(),
                event.getLatitude(),
                event.getLongitude(),
                event.getPrice(),
                event.getCreatedBy().getUsername()
        );
    }

}
