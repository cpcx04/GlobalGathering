package com.salesianos.triana.edu.globalgathering.dto.event;

import java.time.LocalDate;

public record AddAEvent(
        String name,
        String descripcion,

        String url,

        double latitude,

        double longitude,

        double price,

        String ciudad

) {
}
