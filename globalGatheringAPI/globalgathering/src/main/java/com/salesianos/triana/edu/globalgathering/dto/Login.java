package com.salesianos.triana.edu.globalgathering.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record Login(

        @NotBlank()
        String username,

        @NotBlank()
        @Size(min = 6)
        String password
) {
}
