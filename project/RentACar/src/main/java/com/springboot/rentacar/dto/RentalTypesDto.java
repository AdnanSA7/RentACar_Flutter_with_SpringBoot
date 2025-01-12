package com.springboot.rentacar.dto;

import lombok.Data;

import java.util.List;

@Data
public class RentalTypesDto {
    private int id;
    private String rentalType_name;
    private double serviceRate;
    private List<String> carCategoryNames;
}
