package com.springboot.rentacar.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class RentalTypes {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false)
    private String rentalType_name;

    @Column(nullable = false)
    private double serviceRate;

    @ManyToMany(mappedBy = "rentalTypes")
    private List<Cars> cars;

}
