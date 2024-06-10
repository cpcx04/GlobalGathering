package com.salesianos.triana.edu.globalgathering.dto.user;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.salesianos.triana.edu.globalgathering.model.Client;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import org.springframework.security.core.GrantedAuthority;

import java.time.LocalDateTime;
import java.util.Collection;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class ClientResponse {

    protected String id;
    protected String username, email, nombre, role;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd/MM/yyyy HH:mm:ss")
    protected LocalDateTime createdAt;

    public static String getRole(Collection<? extends GrantedAuthority> roleList){
        return roleList.stream().map(GrantedAuthority::getAuthority).toList().get(0);
    }
    public static ClientResponse of(Client user){

        return ClientResponse.builder()
                .id(user.getId().toString())
                .username(user.getUsername())
                .email(user.getEmail())
                .nombre(user.getFullName())
                .createdAt(user.getCreatedAt())
                .role(getRole(user.getAuthorities()))
                .build();
    }

}
