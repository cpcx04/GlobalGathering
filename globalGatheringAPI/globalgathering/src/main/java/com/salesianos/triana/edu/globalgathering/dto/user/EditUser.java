package com.salesianos.triana.edu.globalgathering.dto.user;

import com.salesianos.triana.edu.globalgathering.model.PermissionRole;
import com.salesianos.triana.edu.globalgathering.validation.annotation.UniqueUsername;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record EditUser(
        @NotBlank(message = "{addUser.username.notblank}")
        @UniqueUsername
        String username,
        @NotBlank(message = "{addUser.fullname.notblank}")
        @Size(min = 3, message = "{addUser.fullname.size}")
        String fullName,

        @Email
        String email,

        @NotBlank
        PermissionRole role
) {
}
