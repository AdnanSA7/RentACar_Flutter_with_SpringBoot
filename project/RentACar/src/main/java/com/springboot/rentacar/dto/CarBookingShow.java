package com.springboot.rentacar.dto;

import com.springboot.rentacar.enums.ServiceAction;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class CarBookingShow {
    private long id;
    private long carId;
    private String brand;
    private String model;
    private String registrationNumber;
    private String rentalType; // "Hourly", "Daily", "Outstation Round Trip"
    private Date startDate;
    private Date endDate;
    private String pickupLocation;
    private String dropOffLocation;
    private Integer hours; // For Hourly rental
    private Integer days;
    private Double distance; // For Outstation Round Trip
    private Long driverId;
    private String driverFirstName;
    private String driverLastName;
    private Double totalCost;
    private ServiceAction status;
    private List<String> additionalServiceName;
    private double initialAmount;
    private String paymentMethod;
    private String transactionId;
}

