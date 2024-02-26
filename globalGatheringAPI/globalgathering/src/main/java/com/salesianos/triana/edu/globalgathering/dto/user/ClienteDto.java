package com.salesianos.triana.edu.globalgathering.dto.user;

import com.salesianos.triana.edu.globalgathering.model.Client;

import java.util.UUID;

public record ClienteDto(
        UUID id,
        String username
) {

    public static ClienteDto of (Client cliente){
        return new ClienteDto(
                cliente.getId(),
                cliente.getUsername()
        );
    }
}
