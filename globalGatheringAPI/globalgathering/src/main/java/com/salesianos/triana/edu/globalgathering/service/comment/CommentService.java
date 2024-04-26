package com.salesianos.triana.edu.globalgathering.service.comment;

import com.salesianos.triana.edu.globalgathering.dto.comment.AddACommentDto;
import com.salesianos.triana.edu.globalgathering.dto.comment.GetAllComents;
import com.salesianos.triana.edu.globalgathering.dto.comment.GetSingleCommentDto;
import com.salesianos.triana.edu.globalgathering.exception.comment.NotOwnerOfCommentException;
import com.salesianos.triana.edu.globalgathering.model.Client;
import com.salesianos.triana.edu.globalgathering.model.Comments;
import com.salesianos.triana.edu.globalgathering.model.Post;
import com.salesianos.triana.edu.globalgathering.repository.client.ClientRepository;
import com.salesianos.triana.edu.globalgathering.repository.comment.CommentRepository;
import com.salesianos.triana.edu.globalgathering.repository.post.PostRepository;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.UUID;


@Service
@RequiredArgsConstructor
public class CommentService {

    private final CommentRepository commentRepository;
    private final ClientRepository clientRepository;
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

    @Transactional
    public void delete(UUID id, Client currentUser) {
        Optional<Comments> commentOptional = commentRepository.findById(id);

        if (commentOptional.isPresent()) {
            Comments comment = commentOptional.get();

            String postedByIdAsString = comment.getPostedBy().getId().toString();
            String currentUserIdAsString = currentUser.getId().toString();

            if (postedByIdAsString.equals(currentUserIdAsString)) {
                commentRepository.deleteById(id);
            } else {
                throw new NotOwnerOfCommentException();
            }
        } else {
            throw new EntityNotFoundException("Comment with id: " + id + " not found");
        }
    }


    /*public List<GetAllComents> findAll() {
        return clientRepository.findAllByUsername();
    }*/
}
