package com.salesianos.triana.edu.globalgathering.controller.event;

import com.salesianos.triana.edu.globalgathering.dto.comment.GetSingleCommentDto;
import com.salesianos.triana.edu.globalgathering.dto.event.GetEventDetailDto;
import com.salesianos.triana.edu.globalgathering.dto.event.GetEventDto;
import com.salesianos.triana.edu.globalgathering.service.event.EventService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/event")
@Tag(name = "Event",description = "Controller for take control of the events CRUDS")
public class EventController {

    private final EventService eventService;

    @Operation(summary = "findAll", description = "Find All Events in the database")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The events has been found", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = GetSingleCommentDto.class)), examples = {
                            @ExampleObject(value = """
                                    [
                                        {
                                            "name": "Tour RSP",
                                            "descripcion": "Tour por la casa del Sevilla Fc",
                                            "url": "https://sevillafc.es/sites/default/files/inline-images/estadio-ramon.png",
                                            "latitud": 37.38719483261625,
                                            "longitud": -5.971153027846458,
                                            "price": 12.0,
                                            "createdBy": "cristianpc",
                                            "ciudad": null
                                        },
                                        {
                                            "name": "Catedral de Sevilla",
                                            "descripcion": "Visita a la famosa Catedral de Sevilla",
                                            "url": "https://www.lacatedraldesevilla.org/img/catedral-sevilla-1.jpg",
                                            "latitud": 37.39357029098547,
                                            "longitud": -5.992938705028886,
                                            "price": 10.0,
                                            "createdBy": "cristianpc",
                                            "ciudad": "Sevilla"
                                        }
                                    ]
                                                         """) }) }),
            @ApiResponse(responseCode = "404", description = "Unable to find any events .", content = @Content),
    })
    @GetMapping("/allEvents")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<List<GetEventDto>> findAllEvents() {
        List<GetEventDto> allEvents = eventService.findAll();

        if (allEvents.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }

        return ResponseEntity.ok(allEvents);
    }

    @Operation(summary = "findById", description = "Find a Event in the database")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The event has been found", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = GetEventDetailDto.class)), examples = {
                            @ExampleObject(value = """
                                    {
                                        "nombre": "Catedral de Sevilla",
                                        "fecha": "2024-02-26 15:20:24",
                                        "url": "https://www.lacatedraldesevilla.org/img/catedral-sevilla-1.jpg",
                                        "ciudad": "Sevilla",
                                        "precio": "10.0",
                                        "apuntados": []
                                    }
                                                         """) }) }),
            @ApiResponse(responseCode = "404", description = "Unable to find any event.", content = @Content),
    })
    @GetMapping("/{uuid}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<GetEventDetailDto>findEvent(@PathVariable UUID uuid){
        GetEventDetailDto event = eventService.findAevent(uuid);
        return ResponseEntity.ok(event);
    }

    @Operation(summary = "findByLocation", description = "Find a Event in the database")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The event has been found", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = GetEventDetailDto.class)), examples = {
                            @ExampleObject(value = """

                                                         """) }) }),
            @ApiResponse(responseCode = "404", description = "Unable to find any event.", content = @Content),
    })
    @GetMapping("/location/{ciudad}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<List<GetEventDetailDto>> findEventByLocation(@PathVariable String ciudad) {
        List<GetEventDetailDto> events = eventService.findAeventByLocation(ciudad);
        return ResponseEntity.ok(events);
    }
}
