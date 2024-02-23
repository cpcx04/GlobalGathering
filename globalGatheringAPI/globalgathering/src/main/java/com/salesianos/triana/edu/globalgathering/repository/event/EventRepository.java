package com.salesianos.triana.edu.globalgathering.repository.event;

import com.salesianos.triana.edu.globalgathering.model.Event;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface EventRepository extends JpaRepository<Event, UUID> {
}
