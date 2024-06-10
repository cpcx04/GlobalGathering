package com.salesianos.triana.edu.globalgathering.dto.user;

import com.salesianos.triana.edu.globalgathering.model.PermissionRole;
import com.salesianos.triana.edu.globalgathering.validation.annotation.UniqueUsername;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Size;

public record EditUser(

        @UniqueUsername
        String username,


        @Size(min = 3)
        String fullName,


        @Email()
        String email,

        PermissionRole role
) {
}

