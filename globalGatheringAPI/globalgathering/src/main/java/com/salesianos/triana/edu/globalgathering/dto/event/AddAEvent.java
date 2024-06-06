package com.salesianos.triana.edu.globalgathering.dto.event;

import org.springframework.cglib.core.Local;

import java.time.LocalDate;
import java.util.Date;

public record AddAEvent(
        String name,
        String descripcion,

        String url,

        Double latitude,

        Double longitude,

        Double price,

        String ciudad,

        LocalDate date

) {
}
