package com.springboot.rentacar.dto;

import lombok.Data;

@Data
public class DriverShowDto {
    private long id;
    private String firstName;
    private String lastName;
    private String number;
    private String nid_number;
    private String drivingLicenseNum;
    private byte[] driverImage;
    private Long carId;
}
