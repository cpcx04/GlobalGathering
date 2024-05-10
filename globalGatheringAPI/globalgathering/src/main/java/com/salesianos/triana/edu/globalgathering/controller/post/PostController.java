package com.salesianos.triana.edu.globalgathering.controller.post;

import com.salesianos.triana.edu.globalgathering.dto.post.GetPostDto;
import com.salesianos.triana.edu.globalgathering.dto.post.NewPostDto;
import com.salesianos.triana.edu.globalgathering.dto.post.PostResponse;
import com.salesianos.triana.edu.globalgathering.model.Post;
import com.salesianos.triana.edu.globalgathering.service.post.MediaTypeUrlResource;
import com.salesianos.triana.edu.globalgathering.service.post.PostService;
import com.salesianos.triana.edu.globalgathering.service.post.StorageService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

@RestController
@RequiredArgsConstructor
public class PostController {

    private final StorageService storageService;
    private final PostService postService;


    @PostMapping("/new/post")
    @Operation(summary = "Create a new post", description = "Endpoint to create a new post")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Post created successfully",
                    content = @Content(mediaType = "application/json",
                            schema = @Schema(implementation = GetPostDto.class),
                            examples = @ExampleObject(value = """
                                       {
                                                                   "uuid": "f234e248-0d64-4069-af1d-a321b0678fb8",
                                                                   "comment": "In love con el Villamarin",
                                                                   "relatedEvent": "123e4567-e89b-12d3-a456-426614174001",
                                                                   "image": {
                                                                       "name": "betislogo_859751.png",
                                                                       "uri": "http://localhost:8080/download/betislogo_859751.png",
                                                                       "type": "image/png",
                                                                       "createdBy": "cristianpc",
                                                                       "createdAt": "2024-05-10T18:34:19.7646422",
                                                                       "size": 9313
                                                                   },
                                                                   "createdBy": "cristianpc",
                                                                   "createdAt": "2024-05-10T18:34:19.7806417"
                                                               }
                                    """)
                    )
            ),
            @ApiResponse(responseCode = "400", description = "Invalid request", content = @Content),
            @ApiResponse(responseCode = "401", description = "Unauthorized", content = @Content),
            @ApiResponse(responseCode = "500", description = "Internal server error", content = @Content)
    })
    public ResponseEntity<GetPostDto> newPost(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestPart("post")NewPostDto post,
            @RequestPart("file")  MultipartFile file
    ) {
        PostResponse response = uploadFile(file, userDetails.getUsername());
        Post p = postService.newPost(post, response);
        return ResponseEntity.status(HttpStatus.CREATED).body(GetPostDto.of(p, response));
    }


    @GetMapping("/download/{filename:.+}")
    @Operation(summary = "Download a file", description = "Endpoint to download a file, typically an image")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "File found and downloaded"),
            @ApiResponse(responseCode = "404", description = "File not found"),
            @ApiResponse(responseCode = "500", description = "Internal server error")
    })
    public ResponseEntity<Resource> getFile(@PathVariable String filename) {
        MediaTypeUrlResource resource = (MediaTypeUrlResource) storageService.loadAsResource(filename);
        if (resource == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
        return ResponseEntity.status(HttpStatus.OK)
                .header("Content-Type", resource.getType())
                .body(resource);
    }

    @GetMapping("/posts")
    public ResponseEntity<List<GetPostDto>> getAllUserPosts() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        String username = authentication.getName();
        List<GetPostDto> userPosts = postService.findAllByCreatedBy(username);
        return ResponseEntity.status(HttpStatus.OK).body(userPosts);
    }
    private PostResponse uploadFile(MultipartFile file,String username) {

        String name = storageService.store(file);

        String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/download/")
                .path(name)
                .toUriString();

        return PostResponse.builder()
                .name(name)
                .size(file.getSize())
                .type(file.getContentType())
                .createdBy(username)
                .createdAt(LocalDateTime.now())
                .uri(uri)
                .build();
    }


}
