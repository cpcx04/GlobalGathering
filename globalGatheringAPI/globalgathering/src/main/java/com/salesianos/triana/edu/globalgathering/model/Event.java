package com.salesianos.triana.edu.globalgathering.model;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.Comments;
import org.hibernate.annotations.GenericGenerator;

import java.time.LocalDateTime;
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
    private int latitude;
    private int longitude;
    private LocalDateTime date;
    private double price;

    @ManyToOne
    @JoinColumn(name = "post_related_id")
    private Post postRelated;

    @ManyToOne
    @JoinColumn(name = "created_by_id")
    private Client createdBy;

    @OneToMany(mappedBy = "relatedEvent")
    private List<Comments> comments;

}
