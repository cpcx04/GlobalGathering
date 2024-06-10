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
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
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
import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class PostController {

    private final StorageService storageService;
    private final PostService postService;



    @PostMapping("/new/post")
    @CrossOrigin
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
            //@RequestPart("post")NewPostDto post,
            @RequestPart("post") String post,
            @RequestPart("file")  MultipartFile file
    ) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        String username = authentication.getName();        System.out.println(file);
        PostResponse response = uploadFile(file,username);
        Post p = postService.newPost(post, response);
        return ResponseEntity.status(HttpStatus.CREATED).body(GetPostDto.of(p));
        //System.out.println(post);
        //return ResponseEntity.created(null).body(null);
    }


    @GetMapping("/posts/myposts")
    @Operation(summary = "Get all post", description = "Endpoint to get all posts")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "List Ready",
                    content = @Content(mediaType = "application/json",
                            schema = @Schema(implementation = GetPostDto.class),
                            examples = @ExampleObject(value = """
                                     [
                                                                    {
                                                                        "uuid": "02e914fc-e3aa-4f83-86c0-8b8933f0c65b",
                                                                        "comment": "Tremendo este chico, estuvo en el tour",
                                                                        "relatedEvent": "Tour RSP",
                                                                        "uri": "http://localhost:8080/download/GBFdd0SWMAAHX1G.jpg",
                                                                        "createdBy": "cristianpc",
                                                                        "createdAt": "2024-06-10T13:03:39.926341"
                                                                    },
                                                                    {
                                                                        "uuid": "e857c626-9fee-457a-8cfc-6e0a47ea70d4",
                                                                        "comment": "Estuve de paso por aqui cuando fui a visitar el parque de maria luisa",
                                                                        "relatedEvent": "Parque de Maria Luisa",
                                                                        "uri": "http://localhost:8080/download/photo-of-concrete-building-near-dock-during-night-time-andalucia-andalucia-wallpaper-thumb.jpg",
                                                                        "createdBy": "cristianpc",
                                                                        "createdAt": "2024-05-08T13:03:39.926341"
                                                                    }
                                                                ]
                                    """)
                    )
            ),
            @ApiResponse(responseCode = "400", description = "Invalid request", content = @Content),
            @ApiResponse(responseCode = "401", description = "Unauthorized", content = @Content),
            @ApiResponse(responseCode = "500", description = "Internal server error", content = @Content)
    })
    public ResponseEntity<List<GetPostDto>> getAllUserPosts() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        String username = authentication.getName();
        List<GetPostDto> userPosts = postService.findAllByCreatedBy(username);
        return ResponseEntity.status(HttpStatus.OK).body(userPosts);
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
    public ResponseEntity<List<GetPostDto>> getAllPosts() {
        List<GetPostDto> userPosts = postService.findAll();
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

    @DeleteMapping("/posts/{postId}")
    @Operation(summary = "Delete a post", description = "Endpoint to delete a post by ID")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "Post deleted successfully"),
            @ApiResponse(responseCode = "401", description = "Unauthorized to delete post"),
            @ApiResponse(responseCode = "404", description = "Post not found"),
            @ApiResponse(responseCode = "500", description = "Internal server error")
    })
    public ResponseEntity<?> deletePostById(@PathVariable UUID postId, @AuthenticationPrincipal UserDetails userDetails) {
        try {
            String username = userDetails.getUsername();
            postService.deletePostById(postId, username);
            return ResponseEntity.noContent().build();
        } catch (EntityNotFoundException e) {
            return ResponseEntity.notFound().build();
        } catch (AccessDeniedException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}
