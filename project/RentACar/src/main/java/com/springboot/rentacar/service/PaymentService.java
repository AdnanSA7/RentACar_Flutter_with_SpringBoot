package com.springboot.rentacar.service;

import com.springboot.rentacar.dto.PaymentRequestDto;
import com.springboot.rentacar.dto.PaymentResponseDto;
import com.springboot.rentacar.entity.CarBooking;
import com.springboot.rentacar.entity.Payment;
import com.springboot.rentacar.enums.ServiceAction;
import com.springboot.rentacar.repository.CarBookingRepo;
import com.springboot.rentacar.repository.PaymentRepo;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class PaymentService {

    @Autowired
    private PaymentRepo paymentRepo;

    @Autowired
    private CarBookingRepo carBookingRepo;

    @Autowired
    private ModelMapper modelMapper;


    public List<PaymentResponseDto> getAllPayments() {
        List<Payment> payments = paymentRepo.findAll();
        return payments.stream().map(
                payment -> modelMapper.map(payment, PaymentResponseDto.class))
                .collect(Collectors.toList());
    }


    // Add method to simulate payment processing via a gateway
    private boolean processPaymentWithGateway(String method, double amount) {
        // Placeholder: Replace with actual payment processing logic
        if ("credit_card".equalsIgnoreCase(method)) {
            // Example: Process payment using a credit card (implement the actual gateway API call here)
            System.out.println("Processing payment via credit card: " + amount);
            return true;  // Return 'true' for successful payment
        } else if ("paypal".equalsIgnoreCase(method)) {
            // Example: Process payment using PayPal (implement actual PayPal API call here)
            System.out.println("Processing payment via PayPal: " + amount);
            return true;  // Return 'true' for successful payment
        }
        return false;  // Return 'false' if payment method is unsupported
    }


    // Process Payment
//    @Transactional
//    public Payment processPayment(Long bookingId, double amount, String method, String paymentType) {
//        // Retrieve the booking
//        CarBooking booking = carBookingRepo.findById(bookingId)
//                .orElseThrow(() -> new RuntimeException("Booking not found"));
//
//        // Initialize payment
//        Payment payment = new Payment();
//        payment.setAmount(amount);
//        payment.setPaymentDate(LocalDateTime.now());  // Use LocalDateTime for better date handling
//        payment.setPayment_method(method);
//
//        // Assuming some external payment processing system here
//        boolean paymentSuccess = processPaymentWithGateway(method, amount);
//        payment.setPaymentStatus(paymentSuccess);  // Set payment status based on actual payment result
//
//        // Link payment to booking
//        payment.setCarBooking(booking);
//
//        // Save payment
//        Payment savedPayment = paymentRepo.save(payment);
//
//        // Update booking status based on payment type
//        if ("FULL".equalsIgnoreCase(paymentType) && paymentSuccess) {
//            booking.setStatus(true);  // Booking confirmed for full payment
//        } else if ("DEPOSIT".equalsIgnoreCase(paymentType) && paymentSuccess) {
//            booking.setDepositPaid(true);  // Mark deposit as paid
//        }
//
//        // Save booking updates
//        carBookingRepo.save(booking);
//
//        // Return the saved payment object
//        return savedPayment;
//    }

    @Transactional
    public Payment processPayment(PaymentRequestDto paymentRequestDto) {
        CarBooking booking = carBookingRepo.findById(paymentRequestDto.getBookingId())
                .orElseThrow(() -> new RuntimeException("Booking not found"));

        Payment payment = new Payment();
        payment.setAmount(paymentRequestDto.getAmount());
        payment.setPaymentDate(LocalDateTime.now());
        payment.setPaymentStatus(false);
        payment.setPaymentMethod(paymentRequestDto.getPaymentMethod());
        payment.setInitialAmount(paymentRequestDto.getInitialAmount());
        payment.setTransactionId(paymentRequestDto.getTransactionId());
        payment.setCarBooking(booking);

        Payment savedPayment = paymentRepo.save(payment);

//        Update booking status
        booking.setStatus(ServiceAction.Pending); // Set as pending until admin approval
        carBookingRepo.save(booking);

        return savedPayment;
    }


//    public Payment processPayment(Long bookingId, double amount, String method, String paymentType) {
//        CarBooking booking = carBookingRepo.findById(bookingId)
//                .orElseThrow(() -> new RuntimeException("Booking not found"));
//
//        Payment payment = new Payment();
//        payment.setAmount(amount);
//        payment.setPayment_date(new Date());
//        payment.setPayment_method(method);
//        payment.setPayment_status(true); // Assume successful payment for now
//        payment.setCarBooking(booking);
//
//        Payment savedPayment = paymentRepo.save(payment);
//
//        // Update booking status if full payment is done
//        if ("FULL".equalsIgnoreCase(paymentType)) {
//            booking.setStatus(true);
//        } else if ("DEPOSIT".equalsIgnoreCase(paymentType)) {
//            booking.setDepositPaid(true);
//        }
//        carBookingRepo.save(booking);
//
//        return savedPayment;
//    }

    public Payment confirmPayment(Long paymentId) {
        // Fetch the payment
        Payment payment = paymentRepo.findById(paymentId)
                .orElseThrow(() -> new RuntimeException("Payment not found"));

        // Mark payment as completed
        payment.setPaymentStatus(true);
        paymentRepo.save(payment);

        // Update the booking status
        CarBooking booking = payment.getCarBooking();
        booking.setStatus(ServiceAction.Rented); // Mark booking as completed
        carBookingRepo.save(booking);

        return payment;
    }



    // Update Payment Status
    public Payment updatePaymentStatus(Long paymentId, boolean status) {
        Payment payment = paymentRepo.findById(paymentId)
                .orElseThrow(() -> new RuntimeException("Payment not found"));

        payment.setPaymentStatus(status);
        return paymentRepo.save(payment);
    }

}
