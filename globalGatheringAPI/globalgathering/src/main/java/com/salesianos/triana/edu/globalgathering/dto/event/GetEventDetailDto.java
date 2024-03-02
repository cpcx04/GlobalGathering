package com.salesianos.triana.edu.globalgathering.dto.event;

import com.salesianos.triana.edu.globalgathering.dto.user.ClienteDto;
import com.salesianos.triana.edu.globalgathering.model.Event;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

public record GetEventDetailDto(
        String nombre,
        LocalDate fecha,
        String url,
        String ciudad,
        String precio,
        List<ClienteDto> apuntados
){
    public static GetEventDetailDto toDto(Event event) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return new GetEventDetailDto(
                event.getName(),
                event.getDate(),
                event.getUrl(),
                event.getCiudad(),
                String.valueOf(event.getPrice()),
                event.getClientes().stream()
                        .map(ClienteDto::of)
                        .collect(Collectors.toList())
        );
    }
}
