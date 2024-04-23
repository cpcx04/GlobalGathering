package com.salesianos.triana.edu.globalgathering.controller.admin;

import com.salesianos.triana.edu.globalgathering.dto.user.AddUser;
import com.salesianos.triana.edu.globalgathering.dto.user.ClientResponse;
import com.salesianos.triana.edu.globalgathering.dto.user.EditUser;
import com.salesianos.triana.edu.globalgathering.model.ClientWorker;
import com.salesianos.triana.edu.globalgathering.security.jwt.JwtProvider;
import com.salesianos.triana.edu.globalgathering.service.client.ClientWorkerService;
import io.swagger.v3.oas.annotations.parameters.RequestBody;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
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
    private final AuthenticationManager authManager;
    private final JwtProvider jwtProvider;
    @GetMapping("/clients")
    public ResponseEntity<List<ClientResponse>> getAllClients() {
        List<ClientResponse> clients = userWorkerService.getAllClients();
        return ResponseEntity.ok(clients);
    }
    @PutMapping("/clients/{id}")
    public ResponseEntity<ClientResponse> editClient(@PathVariable UUID id, @RequestBody EditUser editUser) {
        try {
            ClientWorker editedClient = userWorkerService.editClient(id, editUser);
            return ResponseEntity.ok(ClientResponse.of(editedClient));
        } catch (UsernameNotFoundException e) {
            return ResponseEntity.notFound().build();
        }
    }

}
