package com.salesianos.triana.edu.globalgathering.service;

import com.salesianos.triana.edu.globalgathering.dto.AddUser;
import com.salesianos.triana.edu.globalgathering.model.ClientWorker;
import com.salesianos.triana.edu.globalgathering.repository.ClientWorkerRepository;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

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


}
