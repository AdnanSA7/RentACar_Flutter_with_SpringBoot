package com.springboot.rentacar.controller;

import com.springboot.rentacar.dto.CarBookingShow;
import com.springboot.rentacar.dto.PaymentRequestDto;
import com.springboot.rentacar.dto.PaymentResponseDto;
import com.springboot.rentacar.entity.AdditionalService;
import com.springboot.rentacar.entity.CarBooking;
import com.springboot.rentacar.entity.Payment;
import com.springboot.rentacar.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/payments")
@CrossOrigin("*")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @PostMapping()
    public CarBookingShow initiatePayment(@RequestBody PaymentRequestDto paymentRequest) {
       Payment payment = paymentService.processPayment(paymentRequest);

        // Retrieve the booking and prepare the response DTO (CarBookingShow)
        CarBooking booking = payment.getCarBooking();
        CarBookingShow carBookingShow = new CarBookingShow();
        carBookingShow.setId(booking.getId());
        carBookingShow.setCarId(booking.getCar().getId());
        carBookingShow.setBrand(booking.getCar().getBrand());
        carBookingShow.setModel(booking.getCar().getModel());
        carBookingShow.setRegistrationNumber(booking.getCar().getRegistrationNumber());
        carBookingShow.setRentalType(booking.getRentalType());
        carBookingShow.setStartDate(booking.getStartDate());
        carBookingShow.setEndDate(booking.getEndDate());
        carBookingShow.setPickupLocation(booking.getPickup_location());
        carBookingShow.setDropOffLocation(booking.getDropOff_location());
        carBookingShow.setHours(booking.getHours());
        carBookingShow.setDays(booking.getDays());
        carBookingShow.setDistance(booking.getDistance());
        carBookingShow.setStatus(booking.getStatus());

        if (booking.getDriver() != null) {
            carBookingShow.setDriverId(booking.getDriver().getId());
            carBookingShow.setDriverFirstName(booking.getDriver().getFirstName());
            carBookingShow.setDriverLastName(booking.getDriver().getLastName());
        }

        // Add the total cost, status, and payment details
        double totalCost = payment.getAmount();
        carBookingShow.setTotalCost(totalCost);
        carBookingShow.setInitialAmount(payment.getInitialAmount());
        carBookingShow.setPaymentMethod(payment.getPaymentMethod());
        carBookingShow.setTransactionId(payment.getTransactionId());

        // Add additional services details
        List<String> additionalServiceNames = booking.getAdditionalService().stream()
                .map(AdditionalService::getName)
                .collect(Collectors.toList());
        carBookingShow.setAdditionalServiceName(additionalServiceNames);

        // Return response with CarBookingShow details
        return carBookingShow;
    }

    @GetMapping()
    public List<PaymentResponseDto> getPayments() {
        return paymentService.getAllPayments();
    }


    @PostMapping("/confirm/{paymentId}")
    public ResponseEntity<PaymentResponseDto> confirmPayment(@PathVariable Long paymentId) {
        Payment payment = paymentService.confirmPayment(paymentId);

        PaymentResponseDto responseDto = new PaymentResponseDto();
        responseDto.setId(payment.getId());
        responseDto.setAmount(payment.getAmount());
        responseDto.setPaymentStatus(payment.isPaymentStatus());
        responseDto.setPaymentMethod(payment.getPaymentMethod());
        responseDto.setTransactionId(payment.getTransactionId());

        return ResponseEntity.ok(responseDto);
    }

//    @PostMapping
//    public ResponseEntity<Payment> processPayment(
//            @RequestParam Long bookingId,
//            @RequestParam double amount,
//            @RequestParam String method,
//            @RequestParam String paymentType) {
//        Payment payment = paymentService.processPayment(bookingId, amount, method, paymentType);
//        return ResponseEntity.ok(payment);
//    }

}
