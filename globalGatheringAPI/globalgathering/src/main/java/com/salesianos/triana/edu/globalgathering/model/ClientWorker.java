package com.salesianos.triana.edu.globalgathering.model;

import jakarta.persistence.Entity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;


@Entity
@Getter
@Setter
@ToString
@NoArgsConstructor
@SuperBuilder
public class ClientWorker extends Client{
    private boolean jefe;

    public ClientWorker(UUID id, String username, String fullName, String password, String email, List<Event> createdEvents, List<Post> likedPosts, List<Comments> comments, PermissionRole role, boolean accountNonExpired, boolean accountNonLocked, boolean credentialsNonExpired, boolean enabled, LocalDateTime createdAt, LocalDateTime lastPasswordChangeAt, boolean jefe) {
        super(id, username, fullName, password, email, createdEvents, likedPosts, comments, role, accountNonExpired, accountNonLocked, credentialsNonExpired, enabled, createdAt, lastPasswordChangeAt);
        this.jefe = jefe;
    }
}
