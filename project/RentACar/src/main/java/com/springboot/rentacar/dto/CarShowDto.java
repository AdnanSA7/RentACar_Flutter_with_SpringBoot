package com.springboot.rentacar.dto;

import lombok.Data;

import java.util.List;

@Data
public class CarShowDto {
    private long id;
    private String brand;
    private String model;
    private short seats;
    private byte[] carImage;
    private String registrationNumber;
    private String categoryName;
    private List<String> rentalTypeName;
}
