package com.salesianos.triana.edu.globalgathering.controller;

import com.salesianos.triana.edu.globalgathering.dto.AddUser;
import com.salesianos.triana.edu.globalgathering.dto.Login;
import com.salesianos.triana.edu.globalgathering.model.Client;
import com.salesianos.triana.edu.globalgathering.model.ClientWorker;
import com.salesianos.triana.edu.globalgathering.security.jwt.*;
import com.salesianos.triana.edu.globalgathering.service.ClientWorkerService;
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
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

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
