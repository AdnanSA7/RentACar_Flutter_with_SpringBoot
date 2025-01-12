package com.springboot.rentacar.dto;

import com.springboot.rentacar.enums.ServiceAction;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class CarBookingShowDto {
    private long id;
    private long carId;
    private String rentalType; // "Hourly", "Daily", "Outstation Round Trip"
    private Date startDate;
    private Date endDate;
    private String pickupLocation;
    private String dropOffLocation;
    private Integer hours; // For Hourly rental
    private Double distance; // For Outstation Round Trip
    private Long userId;
    private String userFirstName;
    private String userLastName;
    private Long driverId;
    private String driverFirstName;
    private String driverLastName;
    private Double cost;
    private ServiceAction status;
    private List<String> additionalServiceName;
    private Boolean adminApproval;  // Default: false
    private Boolean serviceStart; // Default: false

}

