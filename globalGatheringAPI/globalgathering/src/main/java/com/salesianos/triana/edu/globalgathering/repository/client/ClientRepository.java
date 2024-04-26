package com.salesianos.triana.edu.globalgathering.repository.client;

import com.salesianos.triana.edu.globalgathering.dto.comment.GetAllComents;
import com.salesianos.triana.edu.globalgathering.model.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ClientRepository extends JpaRepository<Client, UUID> {
    Optional<Client> findFirstByUsername(String username);

    Optional<Client> findByUsername(String username);

    boolean existsByUsernameIgnoreCase(String username);

   /* @Query("SELECT c.username, CONCAT(com.content) AS comments " +
           "FROM Client c " +
           "JOIN Comments com ON c.id = com.postedBy " +
           "GROUP BY c.username")
    List<GetAllComents> findAllByUsername();*/
}
