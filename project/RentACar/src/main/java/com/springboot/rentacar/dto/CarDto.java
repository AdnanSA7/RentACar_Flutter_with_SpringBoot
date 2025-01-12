package com.springboot.rentacar.dto;

import lombok.Data;

import java.util.List;

@Data
public class CarDto {
    private String brand;
    private String model;
    private short year;
    private short seats;
    private String color;
    private String registrationNumber;
    private int carCategoryId;
    private List<Integer> rentalTypeIds;
}

