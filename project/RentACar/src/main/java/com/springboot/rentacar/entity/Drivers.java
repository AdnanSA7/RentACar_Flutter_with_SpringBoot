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
public class Drivers {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(nullable = false)
    private String firstName;

    @Column(nullable = false)
    private String lastName;

    @Column(nullable = false)
    private String number;

    @Column(nullable = false)
    private String nid_number;

    @Lob
    @Column(nullable = false, length = 1_000_000)
    private byte[] driverImage;

    @Column(nullable = false)
    private String drivingLicenseNum;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "car_id", nullable = false)
    private Cars car;

    @OneToMany(mappedBy = "driver")
    @JsonIgnoreProperties("driver")
    private List<CarBooking> carBookings;

}
