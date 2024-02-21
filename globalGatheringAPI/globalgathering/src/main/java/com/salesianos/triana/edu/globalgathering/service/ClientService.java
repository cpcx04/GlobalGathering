package com.salesianos.triana.edu.globalgathering.service;

import com.salesianos.triana.edu.globalgathering.model.Client;
import com.salesianos.triana.edu.globalgathering.repository.ClientRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ClientService {

    private final ClientRepository clientRepository;

    public Optional<Client> findById(UUID id){
        return clientRepository.findById(id);
    }

    public boolean userExists(String username) {
        return clientRepository.existsByUsernameIgnoreCase(username);
    }

    public Optional<Client> findByUsername(String currentUsername) {
        return clientRepository.findByUsername(currentUsername);
    }



    public boolean isAdmin(String username) {
        Optional<Client> user = clientRepository.findByUsername(username);
        return user.map(u -> u.getRole().equals("ADMIN")).orElse(false);
    }


}
