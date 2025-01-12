package com.springboot.rentacar.dto;

import lombok.Data;

import java.util.Date;

@Data
public class PaymentDto {
    private double amount;
    private Date paymentDate;
    private boolean paymentStatus;
    private String paymentMethod;
    private String paymentType;
}
