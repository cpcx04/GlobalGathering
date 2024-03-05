package com.salesianos.triana.edu.globalgathering.controller.comment;

import com.salesianos.triana.edu.globalgathering.dto.comment.AddACommentDto;
import com.salesianos.triana.edu.globalgathering.dto.comment.GetSingleCommentDto;
import com.salesianos.triana.edu.globalgathering.model.Client;
import com.salesianos.triana.edu.globalgathering.model.Comments;
import com.salesianos.triana.edu.globalgathering.model.Post;
import com.salesianos.triana.edu.globalgathering.repository.comment.CommentRepository;
import com.salesianos.triana.edu.globalgathering.service.comment.CommentService;
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
@Tag(name="Comments",description = "Controller for comments,it contains methods to control the comments")
@RequestMapping("/comments")
public class CommentController {
    private final CommentService commentService;
    private final CommentRepository commentRepository;

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

    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Creation of a new comment", content = {
                    @Content(mediaType = "application/json", examples = { @ExampleObject(value =
                            """
                                    {
                                        "avatar": "https://www.shareicon.net/data/2016/09/01/822739_user_512x512.png",
                                        "username": "cristianpc",
                                        "content": "Me parece increible la calva de pedro"
                                    }
                                    """) }) }),
            @ApiResponse(responseCode = "400", description = "The creation of the comment has not been done", content = @Content)

    }

    )
    @PostMapping("/new")
    @PreAuthorize("isAuthenticated()")
    @Operation(summary = "addInventoryItem", description = "Create a new Comment")
    public ResponseEntity<GetSingleCommentDto> addComment(@Valid @RequestBody AddACommentDto commentDto, @AuthenticationPrincipal Client client) {
        Comments c = commentService.newComment(commentDto,client);
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(GetSingleCommentDto.of(c));
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Comment deleted", content = {
                    @Content(mediaType = "application/json", examples = { @ExampleObject(value =
                            """
                                    {
                                        "avatar": "https://www.shareicon.net/data/2016/09/01/822739_user_512x512.png",
                                        "username": "cristianpc",
                                        "content": "Me parece increible la calva de pedro"
                                    }
                                    """) }) }),
            @ApiResponse(responseCode = "400", description = "The comment cant be deleted", content = @Content)

    }

    )
    @DeleteMapping("/delete/{uuid}")
    @PreAuthorize("isAuthenticated()")
    @Operation(summary = "deleteAcomment", description = "Delete a comment")
    public ResponseEntity<?> deleteComment(@PathVariable UUID uuid,@AuthenticationPrincipal Client client) {
        commentService.delete(uuid,client);
        return ResponseEntity.noContent().build();
    }

}
