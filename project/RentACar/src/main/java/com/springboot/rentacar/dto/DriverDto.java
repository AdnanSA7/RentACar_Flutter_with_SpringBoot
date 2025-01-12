package com.springboot.rentacar.dto;

import lombok.Data;

@Data
public class DriverDto {
    private String firstName;
    private String lastName;
    private String number;
    private String nidNumber;
    private String drivingLicenseNum;
    private Long carId;
}
