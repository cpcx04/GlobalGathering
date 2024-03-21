package com.salesianos.triana.edu.globalgathering.security.jwt;


import com.salesianos.triana.edu.globalgathering.model.Client;
import com.salesianos.triana.edu.globalgathering.security.errorhandling.JwtTokenException;
import com.salesianos.triana.edu.globalgathering.service.client.ClientService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.web.servlet.HandlerExceptionResolver;

import java.io.IOException;
import java.util.Optional;
import java.util.UUID;

@Log
@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final ClientService clientService;
    private final JwtProvider jwtProvider;

    @Autowired
    @Qualifier("handlerExceptionResolver")
    private HandlerExceptionResolver resolver;



    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {

        String token = getJwtTokenFromRequest(request);

        try {
            if (StringUtils.hasText(token)) {
                if (token.startsWith(JwtProvider.TOKEN_PREFIX)) {

                    token = token.substring(JwtProvider.TOKEN_PREFIX.length());
                    handleAccessToken(token, request, response);
                } else {

                    handleRefreshToken(token, request, response);
                }
            }

            filterChain.doFilter(request, response);

        } catch (JwtTokenException ex) {
            log.info("Authentication error using token JWT: " + ex.getMessage());
            resolver.resolveException(request, response, null, ex);
        }
    }


    private String getJwtTokenFromRequest(HttpServletRequest request) {
        String bearerToken = request.getHeader(JwtProvider.TOKEN_HEADER);
        if (StringUtils.hasText(bearerToken) && bearerToken.startsWith(JwtProvider.TOKEN_PREFIX)) {
            return bearerToken.substring(JwtProvider.TOKEN_PREFIX.length());
        }
        return null;
    }

    private void handleAccessToken(String accessToken, HttpServletRequest request, HttpServletResponse response) {
        try {
            if (jwtProvider.validateToken(accessToken)) {
                UUID userId = jwtProvider.getUserIdFromJwtToken(accessToken);
                Optional<Client> result = clientService.findById(userId);
                if (result.isPresent()) {
                    Client user = result.get();
                    UsernamePasswordAuthenticationToken authentication =
                            new UsernamePasswordAuthenticationToken(
                                    user,
                                    null,
                                    user.getAuthorities()
                            );
                    authentication.setDetails(new WebAuthenticationDetails(request));
                    SecurityContextHolder.getContext().setAuthentication(authentication);
                }
            }
        } catch (JwtTokenException ex) {
            log.info("Authentication error using access token: " + ex.getMessage());
            resolver.resolveException(request, response, null, ex);
        }
    }

    private void handleRefreshToken(String refreshToken, HttpServletRequest request, HttpServletResponse response) {
        try {
            if (jwtProvider.validateRefreshToken(refreshToken)) {
                UUID userId = jwtProvider.getUserIdFromRefreshToken(refreshToken);
                Optional<Client> result = clientService.findById(userId);
                if (result.isPresent()) {
                    Client user = result.get();
                    String newAccessToken = jwtProvider.generateToken(user);
                    String newRefreshToken = jwtProvider.generateRefreshToken(user);

                    response.addHeader("New-Access-Token", JwtProvider.TOKEN_PREFIX + newAccessToken);
                    response.addHeader("New-Refresh-Token", JwtProvider.TOKEN_PREFIX + newRefreshToken);
                }
            }
        } catch (JwtTokenException ex) {
            log.info("Authentication error using refresh token: " + ex.getMessage());
            resolver.resolveException(request, response, null, ex);
        }
    }
}
