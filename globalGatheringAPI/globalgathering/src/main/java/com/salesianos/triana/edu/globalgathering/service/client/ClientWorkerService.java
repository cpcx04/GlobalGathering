package com.salesianos.triana.edu.globalgathering.service.client;

import com.salesianos.triana.edu.globalgathering.dto.user.AddUser;
import com.salesianos.triana.edu.globalgathering.dto.user.ClientResponse;
import com.salesianos.triana.edu.globalgathering.dto.user.EditUser;
import com.salesianos.triana.edu.globalgathering.exception.client.SameUsernameException;
import com.salesianos.triana.edu.globalgathering.model.Client;
import com.salesianos.triana.edu.globalgathering.model.ClientWorker;
import com.salesianos.triana.edu.globalgathering.model.PermissionRole;
import com.salesianos.triana.edu.globalgathering.repository.client.ClientWorkerRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

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

    public ClientWorker editClient(String username, EditUser editUser) {
        ClientWorker client = userWorkerRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("Client not found with username: " + username));

        if (editUser.username() != null) {
            client.setUsername(editUser.username());
        }
        if (editUser.fullName() != null) {
            client.setFullName(editUser.fullName());
        }
        if (editUser.email() != null) {
            client.setEmail(editUser.email());
        }
        if (editUser.role() != null) {
            client.setRole(editUser.role());
        }

        return userWorkerRepository.save(client);
    }


    @Transactional
    public void delete(String username, UserDetails userDetails) {
        if (username.equals(userDetails.getUsername())) {
            throw new SameUsernameException();
        } else {

            ClientWorker userToDelete = userWorkerRepository.findByUsername(username)
                    .orElseThrow(() -> new UsernameNotFoundException("Usuario no encontrado: " + username));

            userWorkerRepository.delete(userToDelete);
        }
    }

    @Transactional
    public void banUser(String username) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        boolean isAdmin = authentication.getAuthorities().stream()
                .anyMatch(grantedAuthority -> grantedAuthority.getAuthority().equals("ROLE_ADMIN"));

        if (!isAdmin) {
            throw new AccessDeniedException("Only admins can ban users.");
        }

        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        if (username.equals(userDetails.getUsername())) {
            throw new SameUsernameException();
        }

        ClientWorker userToBan = userWorkerRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found: " + username));
        userToBan.setBanned(!userToBan.isBanned());
        userWorkerRepository.save(userToBan);
    }

    public List<ClientResponse> getAllBannedClients() {
        List<ClientWorker> getClients = userWorkerRepository.findAll();
        return getClients.stream().map(ClientResponse::of).toList();
    }
}
