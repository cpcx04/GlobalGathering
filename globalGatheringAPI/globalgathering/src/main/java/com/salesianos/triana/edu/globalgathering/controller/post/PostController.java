package com.salesianos.triana.edu.globalgathering.controller.post;

import com.salesianos.triana.edu.globalgathering.dto.post.GetPostDto;
import com.salesianos.triana.edu.globalgathering.dto.post.NewPostDto;
import com.salesianos.triana.edu.globalgathering.dto.post.PostResponse;
import com.salesianos.triana.edu.globalgathering.model.Post;
import com.salesianos.triana.edu.globalgathering.service.post.MediaTypeUrlResource;
import com.salesianos.triana.edu.globalgathering.service.post.PostService;
import com.salesianos.triana.edu.globalgathering.service.post.StorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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

    @PostMapping("/upload/files")
    public ResponseEntity<?> upload(@RequestPart("files") MultipartFile[] files) {

        //FileResponse response = uploadFile(file);

        List<PostResponse> result = Arrays.stream(files)
                .map(this::uploadMultipleFile)
                .toList();

        return ResponseEntity
                //.created(URI.create(response.getUri()))
                .status(HttpStatus.CREATED)
                .body(result);
    }


    @PostMapping("/new/post")
    public ResponseEntity<GetPostDto> newPost(@AuthenticationPrincipal UserDetails userDetails,@RequestPart("post") NewPostDto post, @RequestPart("file") MultipartFile file) {

        PostResponse response = uploadFile(file,userDetails.getUsername());

        Post p = postService.newPost(post,response);

        return ResponseEntity.status(HttpStatus.CREATED).body(GetPostDto.of(p,response));
    }

    @GetMapping("/download/{filename:.+}")
    public ResponseEntity<Resource> getFile(@PathVariable String filename){
        MediaTypeUrlResource resource =
                (MediaTypeUrlResource) storageService.loadAsResource(filename);

        return ResponseEntity.status(HttpStatus.OK)
                .header("Content-Type", resource.getType())
                .body(resource);
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
    private PostResponse uploadMultipleFile(MultipartFile file) {

        String name = storageService.store(file);

        String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/download/")
                .path(name)
                .toUriString();

        return PostResponse.builder()
                .name(name)
                .size(file.getSize())
                .type(file.getContentType())
                .uri(uri)
                .build();
    }



}
