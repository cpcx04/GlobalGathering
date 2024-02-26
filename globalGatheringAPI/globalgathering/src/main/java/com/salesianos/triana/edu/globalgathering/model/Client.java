package com.salesianos.triana.edu.globalgathering.model;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.NaturalId;
import org.hibernate.annotations.UuidGenerator;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;
import java.util.UUID;

@Entity
@SuperBuilder
@EntityListeners(AuditingEntityListener.class)
@Inheritance(strategy = InheritanceType.JOINED)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public abstract class Client implements UserDetails {

    @Id
    @GeneratedValue(generator = "UUID")
    @UuidGenerator
    @Column(columnDefinition = "uuid")
    private UUID id;

    @NaturalId
    @Column(unique = true, updatable = false)
    private String username;

    private String fullName;

    private String password;

    private String email;

    private String avatar;

    @ManyToMany
    @JoinTable(
            name = "apuntados_al_evento",
            joinColumns = @JoinColumn(name = "cliente_id"),
            inverseJoinColumns = @JoinColumn(name = "evento_id")
    )
    private List<Event> apuntados;

    @ManyToMany
    @JoinTable(
            name = "client_liked_posts",
            joinColumns = @JoinColumn(name = "client_id"),
            inverseJoinColumns = @JoinColumn(name = "post_id"))
    private List<Post> likedPosts;

    @OneToMany(mappedBy = "postedBy",cascade = CascadeType.ALL,fetch = FetchType.LAZY)
    private List<Comments> comments;

    @Enumerated(EnumType.STRING)
    private PermissionRole role;

    private boolean accountNonExpired = true;
    private boolean accountNonLocked = true;
    private boolean credentialsNonExpired = true;
    private boolean enabled = true;

    @CreatedDate
    private LocalDateTime createdAt;

    private LocalDateTime lastPasswordChangeAt = LocalDateTime.now();

    @Transient
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        String role = "ROLE_";
        if (this.getRole() == PermissionRole.ADMIN) {
            role += "ADMIN";
        } else {
            role += "USER";
        }
        return List.of(new SimpleGrantedAuthority(role));
    }

    @Transient
    @Override
    public boolean isAccountNonExpired() {
        return accountNonExpired;
    }

    @Transient
    @Override
    public boolean isAccountNonLocked() {
        return accountNonLocked;
    }

    @Transient
    @Override
    public boolean isCredentialsNonExpired() {
        return credentialsNonExpired;
    }

    @Transient
    @Override
    public boolean isEnabled() {
        return enabled;
    }
}


