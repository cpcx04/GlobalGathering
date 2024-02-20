package com.salesianos.triana.edu.globalgathering;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Contact;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.info.License;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@OpenAPIDefinition(info =
@Info(description = "App for take in groups trips and excursions",
		version = "1.0",
		contact = @Contact(email = "pulidocabellochristian@gmail.com", name = "GlobalGathering by Cristian Pulido"),
		license = @License(name = "GlobalGathering"),
		title = "An app for trips"
)
)
public class GlobalgatheringApplication {

	public static void main(String[] args) {
		SpringApplication.run(GlobalgatheringApplication.class, args);
	}

}
