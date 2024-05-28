package com.salesianos.triana.edu.globalgathering.error;

import com.salesianos.triana.edu.globalgathering.dto.event.GetEventDetailDto;
import com.salesianos.triana.edu.globalgathering.error.impl.ApiValidationSubError;
import com.salesianos.triana.edu.globalgathering.exception.client.AlreadyAssignedException;
import com.salesianos.triana.edu.globalgathering.exception.client.BannedUserException;
import com.salesianos.triana.edu.globalgathering.exception.client.SameUsernameException;
import com.salesianos.triana.edu.globalgathering.exception.comment.NotOwnerOfCommentException;
import com.salesianos.triana.edu.globalgathering.security.errorhandling.JwtTokenException;
import io.jsonwebtoken.JwtException;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.web.ErrorResponse;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;


import java.net.URI;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RestControllerAdvice
public class GlobalRestControllerAdvice extends ResponseEntityExceptionHandler {

    @Override
    public ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException exception,
            HttpHeaders headers, HttpStatusCode status, WebRequest request) {
        List<ApiValidationSubError> validationErrors = exception.getBindingResult().getAllErrors().stream()
                .map(ApiValidationSubError::fromObjectError)
                .toList();
        ErrorResponse er = ErrorResponse.builder(exception, HttpStatus.BAD_REQUEST, exception.getMessage())
                .title("Invalid data error")
                .type(URI.create("https://api.globalghatering.com/errors/not-valid"))
                .property("Fields errors", validationErrors)
                .build();
        return ResponseEntity.status(status)
                .body(er);
    }


    @ExceptionHandler({ EntityNotFoundException.class })
    public ErrorResponse handleNotFoundException(EntityNotFoundException exception) {
        return ErrorResponse.builder(exception, HttpStatus.NOT_FOUND, exception.getMessage())
                .title("Entity not found")
                .type(URI.create("https://api.globalghatering.com/errors/not-found"))
                .property("timestamp", Instant.now())
                .build();
    }

    @ExceptionHandler({ BannedUserException.class })
    public ErrorResponse handleBannedUserException(BannedUserException exception) {
        return ErrorResponse.builder(exception, HttpStatus.NOT_FOUND, exception.getMessage())
                .title("Usuario Baneado temporalmente")
                .type(URI.create("https://api.globalghatering.com/errors/ban"))
                .property("timestamp", Instant.now())
                .build();
    }
    @ExceptionHandler({ NotOwnerOfCommentException.class })
    public ErrorResponse handleNotOwnerofCommentException(NotOwnerOfCommentException exception) {
        return ErrorResponse.builder(exception, HttpStatus.NOT_FOUND, exception.getMessage())
                .title("You are not the owner of this comment")
                .type(URI.create("https://api.globalghatering.com/errors/not-found"))
                .property("timestamp", Instant.now())
                .build();
    }

    @ExceptionHandler({ SameUsernameException.class })
    public ErrorResponse sameClientException(SameUsernameException exception) {
        return ErrorResponse.builder(exception, HttpStatus.METHOD_NOT_ALLOWED, exception.getMessage())
                .title("You cant action on your own user")
                .type(URI.create("https://api.globalghatering.com/errors/same-client"))
                .property("timestamp", Instant.now())
                .build();
    }

    @ExceptionHandler({ AlreadyAssignedException.class })
    public ErrorResponse handleAlreadyInException(AlreadyAssignedException exception) {
        return ErrorResponse.builder(exception, HttpStatus.NOT_FOUND, exception.getMessage())
                .title("You are already in this event")
                .type(URI.create("https://api.globalghatering.com/errors/not-found"))
                .property("timestamp", Instant.now())
                .build();
    }

    @ExceptionHandler({ AuthenticationException.class })
    public ErrorResponse handleAuthenticationException(AuthenticationException exception) {
        return ErrorResponse.builder(exception, HttpStatus.UNAUTHORIZED, exception.getMessage())
                .title("AUTHENTICATION")
                .type(URI.create("https://api.globalghatering.com/errors/unauthorized-user"))
                .property("timestamp", Instant.now())
                .build();

    }

    @ExceptionHandler({ AccessDeniedException.class })
    public ErrorResponse handleAccessDeniedException(AccessDeniedException exception) {
        return ErrorResponse.builder(exception, HttpStatus.FORBIDDEN, exception.getMessage())
                .title("ACCESS DENIED")
                .type(URI.create("https://api.globalghatering.com/errors/access-denied"))
                .property("timestamp", Instant.now())
                .build();

    }


    @ExceptionHandler({JwtException.class})
    public ErrorResponse handleTokenException(JwtTokenException exception) {
        return ErrorResponse.builder(exception, HttpStatus.FORBIDDEN, exception.getMessage())
                .title("TOKEN INVALID")
                .type(URI.create("https://api.globalghatering.com/errors/invalid-token"))
                .property("timestamp", Instant.now())
                .build();
    }

}
