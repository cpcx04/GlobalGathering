package com.salesianos.triana.edu.globalgathering.model;

import jakarta.persistence.Entity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;



@Entity
@Getter
@Setter
@ToString
@NoArgsConstructor
@SuperBuilder
public class ClientWorker extends Client{

    private boolean jefe;

}
