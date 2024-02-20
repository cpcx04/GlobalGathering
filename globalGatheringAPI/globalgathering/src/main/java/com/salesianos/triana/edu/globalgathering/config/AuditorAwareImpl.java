package com.salesianos.triana.edu.globalgathering.config;

import com.salesianos.triana.edu.globalgathering.model.Client;
import org.springframework.data.domain.AuditorAware;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Optional;


public class AuditorAwareImpl implements AuditorAware<String> {
    @Override
    public Optional<String> getCurrentAuditor() {
        Authentication authentication =
                SecurityContextHolder.getContext().getAuthentication();

        return Optional.ofNullable(authentication)
                .map(auth -> (Client) auth.getPrincipal())
                .map(Client::getId)
                .map(java.util.UUID::toString);
    }
}
