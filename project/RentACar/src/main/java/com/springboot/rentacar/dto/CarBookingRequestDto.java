package com.springboot.rentacar.dto;

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class CarBookingRequestDto {
    private long carId;
    private String rentalType; // "Hourly", "Daily", "Outstation Round Trip"
    private Date startDate;
    private Date endDate;
    private String pickupLocation;
    private String dropOffLocation;
    private Integer hours; // For Hourly rental
    private Double distance; // For Outstation Round Trip
    private List<Integer> additionalServiceIds;
    private long userId;
}
