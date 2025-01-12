package com.springboot.rentacar.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Payment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(nullable = false)
    private double amount;

    @Column(nullable = false)
    private LocalDateTime paymentDate;

    @Column(nullable = false)
    private boolean paymentStatus = false;

    @Column
    private double initialAmount;

    @Column
    private String paymentMethod;

    @Column
    private String transactionId;

    @OneToOne
    @JoinColumn(name = "booking_id", nullable = false)
    private CarBooking carBooking; // Link to CarBooking

}
