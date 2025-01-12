package com.springboot.rentacar.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class PaymentResponseDto {
    private long id;
    private double amount;
    private LocalDateTime paymentDate;
    private boolean paymentStatus;
    private String paymentMethod;
    private String paymentType;
    private String transactionId;
    private long bookingId;
}
