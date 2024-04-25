package com.salesianos.triana.edu.globalgathering.repository.client;
import com.salesianos.triana.edu.globalgathering.model.ClientWorker;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface ClientWorkerRepository extends JpaRepository<ClientWorker, UUID> {
    Optional<ClientWorker> findByUsername(String username);
}
