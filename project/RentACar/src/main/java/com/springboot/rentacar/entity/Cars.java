package com.springboot.rentacar.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.*;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Cars {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(nullable = false)
    private String brand;

    @Column(nullable = false)
    private String model;

    private short year;

    @Column(nullable = false)
    private short seats;

    private String color;

    @Column(nullable = false)
    private String registrationNumber;

    @Lob
    @Column(nullable = false, length = 1_000_000)
    private byte[] carImage;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "carCategory_id", nullable = false)
    @JsonIgnoreProperties("cars")
    private CarCategory carCategory;

    @OneToOne(mappedBy = "car", cascade = CascadeType.ALL)
    private Drivers driver;

    @OneToMany(mappedBy = "car")
    @JsonIgnoreProperties("car")
    private List<CarBooking> carBookings;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "car_rental_type",
            joinColumns = @JoinColumn(name = "car_id"),
            inverseJoinColumns = @JoinColumn(name = "rental_type_id")
    )
    private List<RentalTypes> rentalTypes;

}
