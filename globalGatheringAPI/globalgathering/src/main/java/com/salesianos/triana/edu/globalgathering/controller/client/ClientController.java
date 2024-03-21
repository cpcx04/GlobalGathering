package com.salesianos.triana.edu.globalgathering.controller.client;

import com.salesianos.triana.edu.globalgathering.dto.event.GetEventDetailDto;
import com.salesianos.triana.edu.globalgathering.dto.user.AddUser;
import com.salesianos.triana.edu.globalgathering.dto.user.Login;
import com.salesianos.triana.edu.globalgathering.model.Client;
import com.salesianos.triana.edu.globalgathering.model.ClientWorker;
import com.salesianos.triana.edu.globalgathering.model.Event;
import com.salesianos.triana.edu.globalgathering.security.jwt.*;
import com.salesianos.triana.edu.globalgathering.security.jwt.JwtUserResponse;
import com.salesianos.triana.edu.globalgathering.service.client.ClientWorkerService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@Tag(name="Client",description = "Controller for clients,it contains methods to control the authentication of the client(register,login,validation...)")
public class ClientController {
    private final ClientWorkerService userWorkerService;
    private final AuthenticationManager authManager;
    private final JwtProvider jwtProvider;
    @Operation(summary = "Create a user")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201 Created", description = "Register was succesful", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = JwtUserResponse.class)), examples = {
                            @ExampleObject(value = """
                                    {
                                        "id": "694d4dec-e043-4c71-8f42-6706506a0fba",
                                        "username": "cristian",
                                        "email": "cristian@gmail.com",
                                        "nombre": "Cristian Pulido",
                                        "role": "ROLE_USER",
                                        "createdAt": "20/02/2024 19:21:33",
                                        "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI2OTRkNGRlYy1lMDQzLTRjNzEtOGY0Mi02NzA2NTA2YTBmYmEiLCJpYXQiOjE3MDg0NTMzMDcsImV4cCI6MTcwODUzOTcwN30.ALbFZqNkPApSf86GtqErLLSuT1t92GN9pFy9-oliLF6_KQYBOtWwZUxPvi6bF745dD7_6nJFCz8B5f_CbfMX1Q"
                                    }
                                                                        """) }) }),
            @ApiResponse(responseCode = "400 Bad Request", description = "Register was not succesful", content = @Content),
    })
    @PostMapping("/auth/register")
    public ResponseEntity<JwtUserResponse> createNewUser(@Valid @RequestBody AddUser addUser) {
        ClientWorker user = userWorkerService.createUser(addUser);
        Authentication authentication = authManager.authenticate(new UsernamePasswordAuthenticationToken(addUser.username(),addUser.password()));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String token = jwtProvider.generateToken(authentication);
        return ResponseEntity.status(HttpStatus.CREATED).body(JwtUserResponse.of(user, token));
    }

    @Operation(summary = "Authenticate and generate JWT for user login")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Login successful", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = JwtUserResponse.class)),
                            examples = @ExampleObject(
                                    value = """
                                                    {
                                                        "id": "694d4dec-e043-4c71-8f42-6706506a0fba",
                                                        "username": "cristian",
                                                        "email": "cristian@gmail.com",
                                                        "nombre": "Cristian Pulido",
                                                        "role": "ROLE_USER",
                                                        "createdAt": "20/02/2024 19:21:33",
                                                        "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI2OTRkNGRlYy1lMDQzLTRjNzEtOGY0Mi02NzA2NTA2YTBmYmEiLCJpYXQiOjE3MDg0NTMyOTQsImV4cCI6MTcwODUzOTY5NH0.ZAflIBl20-TwoQXceLSC4h6xkxJmeSekd-8P6OgVVlEoHWi-W6_RTNwkHGVFkW9uD135X6ZSmm7QLwdG24OPKw"
                                                    }
                                            """
                            ))
            }),
            @ApiResponse(responseCode = "400", description = "Invalid credentials")
    })
    @PostMapping("/auth/login")
    public ResponseEntity<JwtUserResponse> loginUser(@RequestBody Login loginUser) throws Exception {
        Authentication authentication = authManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        loginUser.username(),
                        loginUser.password()));

        SecurityContextHolder.getContext().setAuthentication(authentication);

        String token = jwtProvider.generateToken(authentication);
        Client user = (Client) authentication.getPrincipal();

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(JwtUserResponse.of(user, token));
    }



}