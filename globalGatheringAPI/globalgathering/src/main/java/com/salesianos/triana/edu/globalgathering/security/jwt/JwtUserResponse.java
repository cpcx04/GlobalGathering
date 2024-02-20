package com.salesianos.triana.edu.globalgathering.security.jwt;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.salesianos.triana.edu.globalgathering.dto.ClientResponse;
import com.salesianos.triana.edu.globalgathering.model.Client;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class JwtUserResponse extends ClientResponse {

    private String token;
    private String refreshToken;

    public JwtUserResponse(ClientResponse userResponse) {
        id = userResponse.getId();
        username = userResponse.getUsername();
        nombre = userResponse.getNombre();
        email = userResponse.getEmail();
        createdAt = userResponse.getCreatedAt();
        role = userResponse.getRole();
    }

    public static JwtUserResponse of (Client user, String token) {
        JwtUserResponse result = new JwtUserResponse(ClientResponse.of(user));
        result.setToken(token);
        return result;

    }

}
