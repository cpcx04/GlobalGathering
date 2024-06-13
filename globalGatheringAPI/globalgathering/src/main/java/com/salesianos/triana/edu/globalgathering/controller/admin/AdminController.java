package com.salesianos.triana.edu.globalgathering.controller.admin;

import com.salesianos.triana.edu.globalgathering.dto.user.ClientResponse;
import com.salesianos.triana.edu.globalgathering.dto.user.EditUser;
import com.salesianos.triana.edu.globalgathering.model.ClientWorker;
import com.salesianos.triana.edu.globalgathering.repository.client.ClientWorkerRepository;
import com.salesianos.triana.edu.globalgathering.security.jwt.*;
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
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@Tag(name="Admin",description = "Controller for admins,it contains methods to control all the aplication(register,login,validation...)")
@RequestMapping("/admin")
public class AdminController {

    private final ClientWorkerService userWorkerService;
    private final ClientWorkerRepository clientWorkerRepository;
    private final AuthenticationManager authManager;
    private final JwtProvider jwtProvider;
    @GetMapping("/clients")
    @Operation(summary = "findAll", description = "Find All Single Clients in the database")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The clients has been found", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = ClientResponse.class)), examples = {
                            @ExampleObject(value = """
                                    [
                                        {
                                            "id": "e062bb13-56e8-43ff-94d8-59adea71a0c6",
                                            "username": "cristianpc",
                                            "email": "pulidocabellochristian@gmail.com",
                                            "nombre": "Cristian Pulido",
                                            "role": "ROLE_ADMIN",
                                            "createdAt": null
                                        },
                                        {
                                            "id": "e9d1486c-2b1c-4b8e-87d3-3d158b7fb8bf",
                                            "username": "juancarlosgamer",
                                            "email": "usuario2@gmail.com",
                                            "nombre": "Nombre Usuario 2",
                                            "role": "ROLE_USER",
                                            "createdAt": null
                                        },
                                        {
                                            "id": "6465de6a-102c-4a05-8151-9fe209ecf534",
                                            "username": "viajerotrapero",
                                            "email": "usuario3@gmail.com",
                                            "nombre": "Nombre Usuario 3",
                                            "role": "ROLE_USER",
                                            "createdAt": null
                                        }
                                    ]
                                                         """) }) }),
            @ApiResponse(responseCode = "404", description = "Unable to find any CLIENTS .", content = @Content),
    })
    public ResponseEntity<List<ClientResponse>> getAllClients() {
        List<ClientResponse> clients = userWorkerService.getAllClients();
        return ResponseEntity.ok(clients);
    }
    @GetMapping("/clients/banned")
    @Operation(summary = "findAllBanned", description = "Find All Single Clients in the database that are banned")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The clients has been found", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = ClientResponse.class)), examples = {
                            @ExampleObject(value = """
                                    [
                                        {
                                            "id": "e062bb13-56e8-43ff-94d8-59adea71a0c6",
                                            "username": "cristianpc",
                                            "email": "pulidocabellochristian@gmail.com",
                                            "nombre": "Cristian Pulido",
                                            "role": "ROLE_ADMIN",
                                            "createdAt": null
                                        },
                                        {
                                            "id": "e9d1486c-2b1c-4b8e-87d3-3d158b7fb8bf",
                                            "username": "juancarlosgamer",
                                            "email": "usuario2@gmail.com",
                                            "nombre": "Nombre Usuario 2",
                                            "role": "ROLE_USER",
                                            "createdAt": null
                                        },
                                        {
                                            "id": "6465de6a-102c-4a05-8151-9fe209ecf534",
                                            "username": "viajerotrapero",
                                            "email": "usuario3@gmail.com",
                                            "nombre": "Nombre Usuario 3",
                                            "role": "ROLE_USER",
                                            "createdAt": null
                                        }
                                    ]
                                                         """) }) }),
            @ApiResponse(responseCode = "404", description = "Unable to find any CLIENTS .", content = @Content),
    })
    public ResponseEntity<List<ClientResponse>> getAllClientsBanned() {
        List<ClientResponse> clients = userWorkerService.getAllBannedClients();
        return ResponseEntity.ok(clients);
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The client has been edited", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = ClientResponse.class)), examples = {
                            @ExampleObject(value = """
                                                 {
                                                "id": "e9d1486c-2b1c-4b8e-87d3-3d158b7fb8bf",
                                                "username": "juancarlosgamer",
                                                "email": "usuario2@gmail.com",
                                                "nombre": "Nombre Usuario 2",
                                                "role": "ROLE_USER",
                                                "createdAt": null
                                                }
                                                """) }) }),
            @ApiResponse(responseCode = "404", description = "Any client was found", content = @Content),
    })
    @PutMapping("/clients/{username}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<ClientResponse> editClient(@RequestBody EditUser editUser,@PathVariable String username) {
        try {
            ClientWorker editedClient = userWorkerService.editClient(username, editUser);
            return ResponseEntity.ok(ClientResponse.of(editedClient));
        } catch (UsernameNotFoundException e) {
            return ResponseEntity.notFound().build();
        }
    }


    @ApiResponses({
            @ApiResponse(responseCode = "204", description = "Client Delete"),
            @ApiResponse(responseCode = "405", description = "You cant delete your own user", content = @Content),
    })
    @Operation(summary = "Delete a Client",description = "Delete Client a client checking it exists in the database")
    @DeleteMapping("/clients/{username}")
    public ResponseEntity<?> deleteClientById(@AuthenticationPrincipal UserDetails userDetails, @PathVariable String username){
        userWorkerService.delete(username,userDetails);
        return ResponseEntity.noContent().build();
    }

    @ApiResponses({
            @ApiResponse(responseCode = "204", description = "Client Banned"),
            @ApiResponse(responseCode = "405", description = "You cant ban your own user", content = @Content),
    })
    @PutMapping("/clients/ban/{username}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<?> banAUser(@PathVariable String username) {
            userWorkerService.banUser(username);
            return ResponseEntity.noContent().build();
        }
}

