package com.salesianos.triana.edu.globalgathering.model;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.GenericGenerator;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Entity
@SuperBuilder
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Event {

    @Id
    @GeneratedValue(generator = "uuid2")
    @GenericGenerator(name = "uuid2", strategy = "uuid2")
    @Column(columnDefinition = "uuid")
    private UUID id;

    private String name;
    private String descripcion;
    private String url;

    private double latitude;
    private double longitude;
    private LocalDate date;
    private double price;
    private String ciudad;
    private boolean abierto;

    @ManyToMany(mappedBy = "eventos", fetch = FetchType.EAGER)
    private List<Client> clientes;


    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "post_related_id")
    private List<Post> postRelated;

    @ManyToOne
    @JoinColumn(name = "created_by_id")
    private Client createdBy;

}
