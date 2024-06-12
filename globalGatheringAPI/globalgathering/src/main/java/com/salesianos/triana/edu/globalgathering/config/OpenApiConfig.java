package com.salesianos.triana.edu.globalgathering.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {
    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("GlobalGathering")
                        .version("1.0")
                        .description("App to share events with the world")
                        .license(new License().name("Cristian Pulido General License").url("https://github.com/cpcx04/GlobalGathering")));
    }

}
