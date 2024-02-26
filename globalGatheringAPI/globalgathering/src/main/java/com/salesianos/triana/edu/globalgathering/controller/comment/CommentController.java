package com.salesianos.triana.edu.globalgathering.controller.comment;

import com.salesianos.triana.edu.globalgathering.dto.comment.GetSingleCommentDto;
import com.salesianos.triana.edu.globalgathering.dto.event.GetEventDto;
import com.salesianos.triana.edu.globalgathering.service.comment.CommentService;
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
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@Tag(name="Comments",description = "Controller for comments,it contains methods to control the comments")
@RequestMapping("/comments")
public class CommentController {
    private final CommentService commentService;

    @Operation(summary = "findAll", description = "Find All Single Comments in the database")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "The comments has been found", content = {
                    @Content(mediaType = "application/json", array = @ArraySchema(schema = @Schema(implementation = GetSingleCommentDto.class)), examples = {
                            @ExampleObject(value = """
                                    [
                                        {
                                            "avatar": "https://static.vecteezy.com/system/resources/thumbnails/011/381/900/small/young-businessman-3d-cartoon-avatar-portrait-png.png",
                                            "username": "cristianpc",
                                            "content": "Los mejores 20 euros en invertidos en mi vida fueron la excursion al parque de bolas"
                                        },
                                        {
                                            "avatar": "https://static.vecteezy.com/system/resources/thumbnails/011/381/900/small/young-businessman-3d-cartoon-avatar-portrait-png.png",
                                            "username": "cristianpc",
                                            "content": "El viaje a croacia nos ayudo a desconectar #CroaciaMola#Trips"
                                        }
                                    ]
                                                         """) }) }),
            @ApiResponse(responseCode = "404", description = "Unable to find any comment .", content = @Content),
    })
    @GetMapping("/singleComments")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<List<GetSingleCommentDto>> findAllSigleComments() {
        List<GetSingleCommentDto> allComments = commentService.findSingleComments();

        if (allComments.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(allComments);
    }

}
