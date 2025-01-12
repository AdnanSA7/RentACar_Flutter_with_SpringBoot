package com.springboot.rentacar.dto;

import jakarta.persistence.Column;
import lombok.Data;

@Data
public class AdditionalServicesDto {
    private int id;
    private String name;
    private double cost;
    private String description;
}
