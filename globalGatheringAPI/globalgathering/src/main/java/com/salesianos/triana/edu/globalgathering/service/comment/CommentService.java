package com.salesianos.triana.edu.globalgathering.service.comment;

import com.salesianos.triana.edu.globalgathering.dto.comment.AddACommentDto;
import com.salesianos.triana.edu.globalgathering.dto.comment.GetSingleCommentDto;
import com.salesianos.triana.edu.globalgathering.model.Client;
import com.salesianos.triana.edu.globalgathering.model.Comments;
import com.salesianos.triana.edu.globalgathering.model.Event;
import com.salesianos.triana.edu.globalgathering.model.Post;
import com.salesianos.triana.edu.globalgathering.repository.comment.CommentRepository;
import com.salesianos.triana.edu.globalgathering.repository.post.PostRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;


@Service
@RequiredArgsConstructor
public class CommentService {

    private final CommentRepository commentRepository;
    private final PostRepository postRepository;
    public List<GetSingleCommentDto> findSingleComments() {
        List<Comments> commentsList = commentRepository.findAllCommentWithRelatedPostNullOrEmpty();
        Collections.reverse(commentsList);

        return commentsList.stream()
                .map(GetSingleCommentDto::of)
                .toList();
    }


    public Comments newComment(AddACommentDto nuevo, Client client) {
        if(nuevo.relatedPost() !=null) {
            Post post = postRepository.findById(nuevo.relatedPost())
                    .orElseThrow(() -> new EntityNotFoundException("Post with id " + nuevo.relatedPost() + " not found"));
            Comments comments = new Comments();
            comments.setPostedBy(client);
            comments.setContent(nuevo.content());
            comments.setRelatedPost(post);
            return commentRepository.save(comments);
        }else {
            Comments comments = new Comments();
            comments.setPostedBy(client);
            comments.setContent(nuevo.content());
            return commentRepository.save(comments);
        }
    }
}
