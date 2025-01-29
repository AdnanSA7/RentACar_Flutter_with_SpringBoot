package com.springboot.rentacar.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class CarBookingRequestDto {
    private long carId;
    private String rentalType; // "Hourly", "Daily", "Outstation Round Trip"

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private Date startDate;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private Date endDate;

    private String pickupLocation;
    private String dropOffLocation;
    private Integer hours; // For Hourly rental
    private Double distance; // For Outstation Round Trip
    private List<Integer> additionalServiceIds;
    private long userId;
}
