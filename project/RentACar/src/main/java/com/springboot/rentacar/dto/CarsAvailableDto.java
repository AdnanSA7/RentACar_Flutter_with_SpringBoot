package com.springboot.rentacar.dto;

import lombok.Data;

@Data
public class CarsAvailableDto {
    private long id;
    private String brand;
    private String model;
    private byte[] carImage;
    private String categoryName;
    private String rentalTypeName;
    private double serviceRate;
}
