package com.salesianos.triana.edu.globalgathering.service.client;

import com.salesianos.triana.edu.globalgathering.dto.user.AddUser;
import com.salesianos.triana.edu.globalgathering.dto.user.ClientResponse;
import com.salesianos.triana.edu.globalgathering.model.Client;
import com.salesianos.triana.edu.globalgathering.model.ClientWorker;
import com.salesianos.triana.edu.globalgathering.repository.client.ClientWorkerRepository;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

import static com.salesianos.triana.edu.globalgathering.model.PermissionRole.USER;

@Service
@AllArgsConstructor
public class ClientWorkerService {
    private final ClientWorkerRepository userWorkerRepository;
    private final PasswordEncoder passwordEncoder;
    public ClientWorker createUser(AddUser addUser){
        ClientWorker user = new ClientWorker();
        user.setUsername(addUser.username());
        user.setPassword(passwordEncoder.encode(addUser.password()));
        user.setRole(USER);
        user.setFullName(addUser.fullName());
        user.setEmail(addUser.email());

        return userWorkerRepository.save(user);
    }

    public List<ClientResponse> getAllClients() {
        List<ClientWorker> getClients = userWorkerRepository.findAll();
        return getClients.stream().map(ClientResponse::of).toList();

    }



}
