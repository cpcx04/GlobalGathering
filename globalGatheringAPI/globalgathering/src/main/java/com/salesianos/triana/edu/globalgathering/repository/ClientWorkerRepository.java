package com.salesianos.triana.edu.globalgathering.repository;
import com.salesianos.triana.edu.globalgathering.model.ClientWorker;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.UUID;

@Repository
public interface ClientWorkerRepository extends JpaRepository<ClientWorker, UUID> {
    ClientWorker findByUsername(String username);
}
