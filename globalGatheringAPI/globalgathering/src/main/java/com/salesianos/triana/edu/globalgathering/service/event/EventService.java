package com.salesianos.triana.edu.globalgathering.service.event;

import com.salesianos.triana.edu.globalgathering.dto.event.GetEventDetailDto;
import com.salesianos.triana.edu.globalgathering.dto.event.GetEventDto;
import com.salesianos.triana.edu.globalgathering.model.Event;
import com.salesianos.triana.edu.globalgathering.repository.event.EventRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class EventService {
    private final EventRepository eventRepository;

    public List<GetEventDto> findAll(){
        return eventRepository.findAll()
                .stream()
                .map(GetEventDto::of)
                .toList();
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


}
