package com.salesianos.triana.edu.globalgathering.controller.admin;

import com.salesianos.triana.edu.globalgathering.dto.user.ClientResponse;
import com.salesianos.triana.edu.globalgathering.security.jwt.JwtProvider;
import com.salesianos.triana.edu.globalgathering.service.client.ClientWorkerService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

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

}
