package com.springboot.rentacar.dto;

import lombok.Data;

@Data
public class PaymentRequestDto {
    private Long bookingId;
    private String paymentMethod;
    private String transactionId;
    private double initialAmount;
    private double amount;
}
