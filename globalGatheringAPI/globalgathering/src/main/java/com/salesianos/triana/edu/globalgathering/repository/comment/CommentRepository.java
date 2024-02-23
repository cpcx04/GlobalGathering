package com.salesianos.triana.edu.globalgathering.repository.comment;

import com.salesianos.triana.edu.globalgathering.model.Comments;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.UUID;

@Repository
public interface CommentRepository extends JpaRepository<Comments, UUID> {

    @Query("select c from Comments c where c.relatedPost is null")
    List<Comments> findAllCommentWithRelatedPostNullOrEmpty();

}
