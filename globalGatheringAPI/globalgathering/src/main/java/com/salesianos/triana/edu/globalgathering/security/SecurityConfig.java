package com.salesianos.triana.edu.globalgathering.security;

import com.salesianos.triana.edu.globalgathering.security.jwt.JwtAuthenticationFilter;
import com.salesianos.triana.edu.globalgathering.service.client.UserDetailsServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.config.annotation.web.configurers.HeadersConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;


import static org.springframework.security.web.util.matcher.AntPathRequestMatcher.antMatcher;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
@RequiredArgsConstructor
public class SecurityConfig {

        private final UserDetailsServiceImpl userDetailsService;
        private final PasswordEncoder passwordEncoder;

        private final AuthenticationEntryPoint jwtAuthenticationEntryPoint;
        private final AccessDeniedHandler jwtAccessDeniedHandler;
        private final JwtAuthenticationFilter jwtAuthenticationFilter;

        @Bean
        public AuthenticationManager authenticationManager(HttpSecurity http) throws Exception {
                AuthenticationManagerBuilder authenticationManagerBuilder = http
                                .getSharedObject(AuthenticationManagerBuilder.class);

                AuthenticationManager authenticationManager = authenticationManagerBuilder
                                .authenticationProvider(authenticationProvider())
                                .build();

                return authenticationManager;

        }

        @Bean
        public DaoAuthenticationProvider authenticationProvider() {
                DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();

                authenticationProvider.setUserDetailsService(userDetailsService);
                authenticationProvider.setPasswordEncoder(passwordEncoder);
                authenticationProvider.setHideUserNotFoundExceptions(false);

                return authenticationProvider;

        }

        @Bean
        public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {

                http
                                .cors(Customizer.withDefaults())
                                .csrf((csrf) -> csrf
                                                .ignoringRequestMatchers(antMatcher("/**")))

                                .exceptionHandling((exceptionHandling) -> exceptionHandling
                                                .authenticationEntryPoint(jwtAuthenticationEntryPoint)
                                                .accessDeniedHandler(jwtAccessDeniedHandler))

                                .sessionManagement((session) -> session
                                                .sessionCreationPolicy(SessionCreationPolicy.STATELESS))

                                .authorizeHttpRequests((authz) -> authz
                                        .requestMatchers(
                                                antMatcher("/users/**"))
                                        .hasRole("ADMIN")
                                        .anyRequest().authenticated());

                http.addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);

                http.headers((headers) -> headers
                                .frameOptions(HeadersConfigurer.FrameOptionsConfig::disable));

                return http.build();
        }

        @Bean
        public WebSecurityCustomizer webSecurityCustomizer() {
                return (web -> web.ignoring()
                                .requestMatchers(
                                                antMatcher("/auth/register"),
                                                antMatcher("/auth/login"),
                                                antMatcher("/h2-console/**"),
                                                antMatcher("/auth/**"),
                                                antMatcher("/auth/**"),
                                                antMatcher("/swagger/**"),
                                                antMatcher("/swagger-ui/**"),
                                                antMatcher("/v3/api-docs/**"),
                                                antMatcher("/api-docs"),
                                                antMatcher("/error")
                                ));
        }
}