package com.salesianos.triana.edu.globalgathering.service.event;

import com.salesianos.triana.edu.globalgathering.dto.event.GetEventDto;
import com.salesianos.triana.edu.globalgathering.repository.event.EventRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

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

}
