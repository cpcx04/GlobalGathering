package com.salesianos.triana.edu.globalgathering.controller.event;
import com.salesianos.triana.edu.globalgathering.dto.comment.GetSingleCommentDto;
import com.salesianos.triana.edu.globalgathering.dto.event.AddAEvent;
import com.salesianos.triana.edu.globalgathering.dto.event.GetEventDetailDto;
import com.salesianos.triana.edu.globalgathering.dto.event.GetEventDto;
import com.salesianos.triana.edu.globalgathering.model.Client;
import com.salesianos.triana.edu.globalgathering.model.Event;
import com.salesianos.triana.edu.globalgathering.service.event.EventService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

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
                                    [
                                        {
                                            "nombre": "Tour RSP",
                                            "fecha": "2024-02-29",
                                            "url": "https://sevillafc.es/sites/default/files/inline-images/estadio-ramon.png",
                                            "ciudad": "Sevilla",
                                            "precio": "12.0",
                                            "apuntados": [
                                                {
                                                    "id": "e062bb13-56e8-43ff-94d8-59adea71a0c6",
                                                    "username": "cristianpc"
                                                }
                                            ]
                                        },
                                        {
                                            "nombre": "Catedral de Sevilla",
                                            "fecha": "2024-02-29",
                                            "url": "https://www.lacatedraldesevilla.org/img/catedral-sevilla-1.jpg",
                                            "ciudad": "Sevilla",
                                            "precio": "10.0",
                                            "apuntados": [
                                                {
                                                    "id": "e062bb13-56e8-43ff-94d8-59adea71a0c6",
                                                    "username": "cristianpc"
                                                }
                                            ]
                                        },
                                        {
                                            "nombre": "Parque de Maria Luisa",
                                            "fecha": "2024-02-29",
                                            "url": "https://offloadmedia.feverup.com/sevillasecreta.co/wp-content/uploads/2020/06/24070607/shutterstock_1324665797-1-1024x651.jpg",
                                            "ciudad": "Sevilla",
                                            "precio": "15.0",
                                            "apuntados": []
                                        }
                                    ]
                                                         """) }) }),
            @ApiResponse(responseCode = "404", description = "Unable to find any event.", content = @Content),
    })
    @GetMapping("/location/{ciudad}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<List<GetEventDetailDto>> findEventByLocation(@PathVariable String ciudad) {
        List<GetEventDetailDto> events = eventService.findAeventByLocation(ciudad);
        return ResponseEntity.ok(events);
    }

    @Operation(summary = "Subscribe a Client", description = "Subscribe a Client in the database")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The client susbcribe to the event", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = GetEventDetailDto.class)), examples = {
                            @ExampleObject(value = """
                                    {
                                        "nombre": "Catedral de Sevilla",
                                        "fecha": "2024-02-29",
                                        "url": "https://www.lacatedraldesevilla.org/img/catedral-sevilla-1.jpg",
                                        "ciudad": "Sevilla",
                                        "precio": "10.0",
                                        "apuntados": [
                                            {
                                                "id": "e062bb13-56e8-43ff-94d8-59adea71a0c6",
                                                "username": "cristianpc"
                                            }
                                        ]
                                    }
                                                         """) }) }),
            @ApiResponse(responseCode = "404", description = "Unable to subscribe to any event.", content = @Content),
    })
    @PutMapping("/apuntar/me/{uuid}")
    @PreAuthorize("isAuthenticated()")
    public GetEventDetailDto assignAparticipant(@PathVariable UUID uuid){
        Event event = eventService.assignAclient(uuid);
        return GetEventDetailDto.toDto(event);
    }


    @GetMapping("/get/assigned")
    @PreAuthorize("isAuthenticated()")
    public List<GetEventDto> getMyEvents(){
        List<GetEventDto> event = eventService.findMyEvent();
        return event;
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Creation of a new event", content = {
                    @Content(mediaType = "application/json", examples = { @ExampleObject(value =
                            """
                                    {
                                        "id": "b582965b-0a66-47a1-b0d4-ca1b8c77ce96",
                                        "name": "Paracaidismo Torre Pelli",
                                        "descripcion": "Paracaidismo desde 1500m sobre la torre pelli",
                                        "url": "https://cuponassets.cuponatic-latam.com/backendPe/uploads/imagenes_descuentos/108281/288674eee06d220ca81edcac360b7357d0cd224e.XL2.jpg",
                                        "latitud": 37.3955175804586,
                                        "longitud": -6.011312152239021,
                                        "price": 120.0,
                                        "createdBy": "cristianpc",
                                        "ciudad": "Sevilla",
                                        "date": "2024-03-04"
                                    }
                                    """) }) }),
            @ApiResponse(responseCode = "400", description = "The creation of the event has not been done", content = @Content)

    }

    )
    @PostMapping("/new")
    @PreAuthorize("isAuthenticated()")
    @Operation(summary = "addAevent", description = "Create a new Event")
    public ResponseEntity<GetEventDto> addComment(@Valid @RequestBody AddAEvent addAEvent, @AuthenticationPrincipal Client client) {
        Event e = eventService.newEvent(addAEvent,client);
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(GetEventDto.of(e));
    }

    @Operation(summary = "updateEvent", description = "Update an existing Event")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The event has been updated", content = {
                    @Content(mediaType = "application/json", schema = @Schema(implementation = GetEventDto.class), examples = {
                            @ExampleObject(value = """
                                {
                                    "id": "b582965b-0a66-47a1-b0d4-ca1b8c77ce96",
                                    "name": "Updated Event Name",
                                    "descripcion": "Updated description",
                                    "url": "https://example.com/updated-image.jpg",
                                    "latitude": 37.3955175804586,
                                    "longitude": -6.011312152239021,
                                    "price": 150.0,
                                    "createdBy": "cristianpc",
                                    "ciudad": "Sevilla",
                                    "date": "2024-03-04"
                                }
                                """) }) }),
            @ApiResponse(responseCode = "404", description = "Unable to find the event to update.", content = @Content),
            @ApiResponse(responseCode = "400", description = "Invalid input for the event.", content = @Content)
    })
    @PutMapping("/{uuid}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<GetEventDto> updateEvent(@PathVariable UUID uuid, @Valid @RequestBody AddAEvent updateEventDto) {
        Event updatedEvent = eventService.updateEvent(uuid, updateEventDto);
        return ResponseEntity.ok(GetEventDto.of(updatedEvent));
    }
    @Operation(summary = "deleteEvent", description = "Delete an existing Event")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "The event has been deleted"),
            @ApiResponse(responseCode = "404", description = "Unable to find the event to delete.", content = @Content)
    })
    @DeleteMapping("/{uuid}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Void> deleteEvent(@PathVariable UUID uuid) {
        eventService.deleteEvent(uuid);
        return ResponseEntity.noContent().build();
    }


}
