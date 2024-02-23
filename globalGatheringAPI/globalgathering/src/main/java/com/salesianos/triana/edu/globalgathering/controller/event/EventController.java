package com.salesianos.triana.edu.globalgathering.controller.event;

import com.salesianos.triana.edu.globalgathering.dto.event.GetEventDto;
import com.salesianos.triana.edu.globalgathering.service.event.EventService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/event")
@Tag(name = "Event",description = "Controller for take control of the events CRUDS")
public class EventController {
    private final EventService eventService;

    @Operation(summary = "findAll", description = "Find All Events in the database")
    @GetMapping("/allEvents")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<List<GetEventDto>> findAllEvents() {
        List<GetEventDto> allEvents = eventService.findAll();

        if (allEvents.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(allEvents);
    }
}
