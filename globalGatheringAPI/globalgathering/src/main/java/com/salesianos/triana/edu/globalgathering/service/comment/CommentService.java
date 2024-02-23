package com.salesianos.triana.edu.globalgathering.service.comment;

import com.salesianos.triana.edu.globalgathering.dto.comment.GetSingleCommentDto;
import com.salesianos.triana.edu.globalgathering.repository.comment.CommentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CommentService {

    private final CommentRepository commentRepository;
    public List<GetSingleCommentDto> findSingleComments(){
     return commentRepository.findAllCommentWithRelatedPostNullOrEmpty()
             .stream()
             .map(GetSingleCommentDto::of)
             .toList();
    }
}
