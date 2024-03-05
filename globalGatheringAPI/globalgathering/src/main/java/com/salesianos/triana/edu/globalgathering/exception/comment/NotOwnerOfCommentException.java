package com.salesianos.triana.edu.globalgathering.exception.comment;

public class NotOwnerOfCommentException extends RuntimeException{

    public NotOwnerOfCommentException(){super("You cant delete this comment");}
}
