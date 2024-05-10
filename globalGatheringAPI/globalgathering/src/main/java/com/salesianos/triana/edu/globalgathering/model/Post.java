package com.salesianos.triana.edu.globalgathering.model;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.GenericGenerator;

import java.util.List;
import java.util.UUID;

@Entity
@SuperBuilder
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Post {

    @Id
    @GeneratedValue(generator = "uuid2")
    @GenericGenerator(name = "uuid2", strategy = "uuid2")
    @Column(columnDefinition = "uuid")
    private UUID id;

    @ManyToOne
    @JoinColumn(name = "related_event_id")
    private Event relatedEvent;

    @ManyToOne
    @JoinColumn(name = "related_trip_id")
    private Event relatedTrip;

    private String comment;

    private String name;

    private String uri;

    private  String type;

    private long size;

    @OneToMany(mappedBy = "relatedPost", cascade = CascadeType.ALL)
    private List<Comments> comments;


}
