package com.salesianos.triana.edu.globalgathering.dto.post;

import com.salesianos.triana.edu.globalgathering.model.Post;
import com.salesianos.triana.edu.globalgathering.service.post.MediaTypeUrlResource;

import jakarta.persistence.OneToOne;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PostResponse {

    private String name;
    private String uri;
    private String type;
    private String createdBy;
    @CreatedDate
    private LocalDateTime createdAt;
    private long size;


}
