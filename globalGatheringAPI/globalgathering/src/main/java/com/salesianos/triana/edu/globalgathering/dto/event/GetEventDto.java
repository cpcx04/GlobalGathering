package com.salesianos.triana.edu.globalgathering.dto.event;

import com.salesianos.triana.edu.globalgathering.model.Event;

import java.util.UUID;

public record GetEventDto(

       UUID id,
       String name,
       String descripcion,
       String url,
       double latitud,
       double longitud,
       double price,
       String createdBy,
       String ciudad
){
    public static GetEventDto of (Event event){
        return new GetEventDto(
                event.getId(),
                event.getName(),
                event.getDescripcion(),
                event.getUrl(),
                event.getLatitude(),
                event.getLongitude(),
                event.getPrice(),
                event.getCreatedBy().getUsername(),
                event.getCiudad()
        );
    }

}
