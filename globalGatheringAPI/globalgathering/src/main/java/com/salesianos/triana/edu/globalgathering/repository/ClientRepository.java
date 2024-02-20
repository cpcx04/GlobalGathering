package com.salesianos.triana.edu.globalgathering.repository;

import com.salesianos.triana.edu.globalgathering.model.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface ClientRepository extends JpaRepository<Client, UUID> {
    Optional<Client> findFirstByUsername(String username);

    Optional<Client> findByUsername(String username);

    boolean existsByUsernameIgnoreCase(String username);
}
