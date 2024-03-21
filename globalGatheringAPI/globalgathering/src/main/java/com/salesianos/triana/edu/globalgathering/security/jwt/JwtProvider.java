package com.salesianos.triana.edu.globalgathering.security.jwt;


import com.salesianos.triana.edu.globalgathering.model.Client;
import com.salesianos.triana.edu.globalgathering.security.errorhandling.JwtTokenException;
import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import jakarta.annotation.PostConstruct;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.UUID;

@Log
@Service
public class JwtProvider {
    public static final String TOKEN_TYPE = "JWT";
    public static final String TOKEN_HEADER = "Authorization";
    public static final String TOKEN_PREFIX = "Bearer ";

    @Value("${jwt.secret}")
    private String jwtSecret;

    @Value("${jwt.duration}")
    private int jwtLifeInDays;

    @Value("${jwt.refresh.duration}")
    private int jwtRefreshLifeInDays;
    private JwtParser jwtParser;

    private SecretKey secretKey;

    @PostConstruct
    public void init() {

        secretKey = Keys.hmacShaKeyFor(jwtSecret.getBytes());

        //jwtParser = Jwts.parserBuilder()
        jwtParser = Jwts.parser()
                //.setSigningKey(secretKey)
                .verifyWith(secretKey)
                .build();
    }


    public String generateToken(Authentication authentication) {
        Object principal = authentication.getPrincipal();

        if (principal instanceof Client user) {
            return generateToken(user);
        } else {
            throw new IllegalArgumentException("Authentication principal is not of type" + principal);
        }
    }


    public String generateToken(Client user) {
        Date tokenExpirationDateTime =
                Date.from(
                        LocalDateTime
                                .now()
                                .plusDays(jwtLifeInDays)
                                //.plusMinutes(jwtLifeInMinutes)
                                .atZone(ZoneId.systemDefault())
                                .toInstant()
                );

        return Jwts.builder()
                .header().type(TOKEN_TYPE)
                .and()
                .subject(user.getId().toString())
                .issuedAt(new Date())
                .expiration(tokenExpirationDateTime)
                .signWith(secretKey)
                .compact();
                /*.setHeaderParam("typ", TOKEN_TYPE)
                .setSubject(user.getId().toString())
                .setIssuedAt(new Date())
                .setExpiration(tokenExpirationDateTime)
                .signWith(secretKey)
                .compact();*/

    }


    public UUID getUserIdFromJwtToken(String token) {



        return UUID.fromString(
                //jwtParser.parseClaimsJws(token).getBody().getSubject()
                jwtParser.parseSignedClaims(token).getPayload().getSubject()
        );
    }


    public boolean validateToken(String token) {

        try {
            //jwtParser.parseClaimsJws(token);
            jwtParser.parse(token);
            return true;
        } catch (SignatureException | MalformedJwtException | ExpiredJwtException | UnsupportedJwtException | IllegalArgumentException ex) {
            log.info("Error con el token: " + ex.getMessage());
            throw new JwtTokenException(ex.getMessage());
        }
        //return false;

    }

    public String generateRefreshToken(Client user) {
        Date refreshTokenExpirationDateTime =
                Date.from(
                        LocalDateTime
                                .now()
                                .plusDays(jwtRefreshLifeInDays)
                                .atZone(ZoneId.systemDefault())
                                .toInstant()
                );

        return Jwts.builder()
                .setHeaderParam("typ", TOKEN_TYPE)
                .setSubject(user.getId().toString())
                .setIssuedAt(new Date())
                .setExpiration(refreshTokenExpirationDateTime)
                .signWith(secretKey)
                .compact();
    }


    public UUID getUserIdFromRefreshToken(String refreshToken) {
        Claims claims = jwtParser.parseClaimsJws(refreshToken).getBody();
        String subject = claims.getSubject();
        return UUID.fromString(subject);
    }


    public boolean validateRefreshToken(String refreshToken) {
        try {
            jwtParser.parse(refreshToken);
            return true;
        } catch (SignatureException | MalformedJwtException | ExpiredJwtException | UnsupportedJwtException | IllegalArgumentException ex) {
            log.info("Error with refresh token: " + ex.getMessage());
            return false;
        }
    }


}
