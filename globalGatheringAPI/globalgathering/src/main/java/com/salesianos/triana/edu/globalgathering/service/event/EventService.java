package com.salesianos.triana.edu.globalgathering.service.event;

import com.salesianos.triana.edu.globalgathering.dto.event.AddAEvent;
import com.salesianos.triana.edu.globalgathering.dto.event.GetEventDetailDto;
import com.salesianos.triana.edu.globalgathering.dto.event.GetEventDto;
import com.salesianos.triana.edu.globalgathering.exception.client.AlreadyAssignedException;
import com.salesianos.triana.edu.globalgathering.model.Client;
import com.salesianos.triana.edu.globalgathering.model.Event;
import com.salesianos.triana.edu.globalgathering.repository.client.ClientRepository;
import com.salesianos.triana.edu.globalgathering.repository.event.EventRepository;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class EventService {

    private final EventRepository eventRepository;
    private final ClientRepository clientRepository;

    public List<GetEventDto> findAll(){
        List<Event> eventList = eventRepository.findAll();
        Collections.reverse(eventList);

        return eventList.stream().map(GetEventDto::of).toList();
    }

    public GetEventDetailDto findAevent(UUID uuid) {
        Event event = eventRepository.findById(uuid)
                .orElseThrow(() -> new EntityNotFoundException("Event with id " + uuid + " not found"));
        return GetEventDetailDto.toDto(event);
    }

    public List<GetEventDetailDto> findAeventByLocation(String ciudad) {
        List<Event> events = eventRepository.findByCiudad(ciudad);

        if (events.isEmpty()) {
            throw new EntityNotFoundException("No events found in city: " + ciudad);
        }

        return events.stream()
                .map(GetEventDetailDto::toDto)
                .collect(Collectors.toList());
    }

    @Transactional
    public Event assignAclient(UUID eventId) {
        Event event = eventRepository.findById(eventId)
                .orElseThrow(() -> new EntityNotFoundException("Event with id " + eventId + " not found"));
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        String currentUsername = authentication.getName();
        Client client = clientRepository.findByUsername(currentUsername)
                .orElseThrow(() -> new EntityNotFoundException("Client with username " + currentUsername + " not found"));

        if (event.getClientes().contains(client)) {
            throw new AlreadyAssignedException();
        }

        event.getClientes().add(client);
        client.getEventos().add(event);

        return eventRepository.save(event);
    }


    public List<GetEventDto> findMyEvent() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String currentUsername = authentication.getName();
        Optional<Client> optionalClient = clientRepository.findByUsername(currentUsername);
        if (optionalClient.isPresent()) {

            Client client = optionalClient.get();
            List<Event> myEvents = client.getEventos();
            return myEvents.stream().map(GetEventDto::of).collect(Collectors.toList());
        } else {
            throw new EntityNotFoundException("Client not found for username: " + currentUsername);
        }
    }

    public Event newEvent(AddAEvent nuevo,Client client){
        Event e = new Event();
        e.setName(nuevo.name());
        e.setDescripcion(nuevo.descripcion());
        e.setUrl(nuevo.url());
        e.setLatitude(nuevo.latitude());
        e.setLongitude(nuevo.longitude());
        e.setPrice(nuevo.price());
        e.setDate(LocalDate.now());
        e.setCreatedBy(client);
        e.setCiudad(nuevo.ciudad());
        e.setAbierto(true);

        return eventRepository.save(e);
    }
}
