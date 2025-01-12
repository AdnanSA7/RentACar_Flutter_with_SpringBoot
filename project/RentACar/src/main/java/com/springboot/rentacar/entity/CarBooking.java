package com.springboot.rentacar.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.springboot.rentacar.enums.ServiceAction;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CarBooking {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(nullable = false)
    private Date startDate;

    @Column
    private Date endDate;

    @Column(nullable = false)
    private String pickup_location;

    @Column
    private String dropOff_location;

    @Column
    @Enumerated(EnumType.STRING)
    private ServiceAction status;

    @Column(nullable = false)
    private double cost;

    @Column(nullable = false)
    private String rentalType; // "Hourly", "Daily", "Outstation Round Trip"

    @Column
    private Integer hours; // For Hourly rental (optional, nullable)

    @Column
    private Integer days; // For Daily rental (optional, nullable)

    @Column
    private Double distance; // For Outstation Round Trip (optional, nullable)

    @Column
    private Boolean completeService; // Final service status (false by default)

    @Column
    private Boolean adminApproval;  // Default: false

    @Column
    private Boolean serviceStart; // Default: false

    @Column
    private Boolean depositPaid = false; // Deposit payment status (false by default)

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "driver_id")
    @JsonIgnoreProperties("carBookings")
    private Drivers driver;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "user_id")
    @JsonIgnoreProperties("carBookings")
    private Users user;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "car_id")
    @JsonIgnoreProperties("carBookings")
    private Cars car;

    @OneToOne(mappedBy = "carBooking", fetch = FetchType.LAZY)
    @JsonIgnoreProperties("carBooking") // This will avoid infinite recursion during serialization
    private Payment payment;

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(
            name = "booking_additional_service",
            joinColumns = @JoinColumn(name = "booking_id"),
            inverseJoinColumns = @JoinColumn(name = "service_id")
    )
    private List<AdditionalService> additionalService;

}
