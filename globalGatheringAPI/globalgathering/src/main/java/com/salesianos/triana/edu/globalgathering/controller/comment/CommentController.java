package com.salesianos.triana.edu.globalgathering.controller.comment;

import com.salesianos.triana.edu.globalgathering.dto.comment.GetSingleCommentDto;
import com.salesianos.triana.edu.globalgathering.dto.event.GetEventDto;
import com.salesianos.triana.edu.globalgathering.service.comment.CommentService;
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
@Tag(name="Comments",description = "Controller for comments,it contains methods to control the comments")
@RequestMapping("/comments")
public class CommentController {
    private final CommentService commentService;

    @Operation(summary = "findAll", description = "Find All Single Comments in the database")
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
