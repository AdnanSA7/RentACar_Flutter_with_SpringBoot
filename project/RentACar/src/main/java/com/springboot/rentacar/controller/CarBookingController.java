package com.springboot.rentacar.controller;

import com.springboot.rentacar.dto.CarBookingRequestDto;
import com.springboot.rentacar.dto.CarBookingShowDto;
import com.springboot.rentacar.entity.CarBooking;
import com.springboot.rentacar.enums.ServiceAction;
import com.springboot.rentacar.repository.CarBookingRepo;
import com.springboot.rentacar.service.CarBookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("api/bookings")
@CrossOrigin("*")
public class CarBookingController {

    @Autowired
    private CarBookingService carBookingService;

    @Autowired
    private CarBookingRepo carBookingRepo;

//    @GetMapping("{date}")
//    public List<CarBooking> getCarsByDate(@PathVariable("date") LocalDate date){
//        return carBookingService.findByDate(date);
//    }

//    @PostMapping("book")
//    public CarBookingShow bookCar(@RequestBody CarBookingRequestDto bookingRequest) {
//        CarBookingShow booking = carBookingService.bookCar(bookingRequest);
//        return booking;
//    }

    @GetMapping
    public List<CarBookingShowDto> getBookings(){
        return carBookingService.getAll();
    }


    @PostMapping
    public CarBookingShowDto createBooking(@RequestBody CarBookingRequestDto requestDto) {
        CarBookingShowDto bookingDetails = carBookingService.createBookingAndGetDetails(requestDto);
        return bookingDetails;
    }

//    @PatchMapping("{id}/status")
//    public ResponseEntity<CarBooking> updateBookingStatus(
//            @PathVariable Long id,
//            @RequestParam ServiceAction status) {
//        CarBooking booking = carBookingRepo.findById(id)
//                .orElseThrow(() -> new RuntimeException("Booking not found"));
//
//        booking.setStatus(status); // Set status to true or false
//        carBookingRepo.save(booking);
//
//        return ResponseEntity.ok(booking);
//    }

    @PutMapping("{id}/status")
    public ResponseEntity<Map<String, String>> updateBookingStatus(
            @PathVariable Long id,
            @RequestParam("status") ServiceAction status) { // The "status" parameter is expected from the query string
        CarBooking booking = carBookingRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Booking not found"));

        booking.setStatus(status);  // Set the status to 'Rented' or 'Pending' (ServiceAction enum)

        if (status == ServiceAction.Rented){
            booking.setDepositPaid(true);
        }
        carBookingRepo.save(booking);  // Save the updated booking

        // Return the success message in JSON format
        Map<String, String> response = new HashMap<>();
        response.put("message", "Status updated successfully");

        return ResponseEntity.ok(response);  // Return JSON response
    }

    @GetMapping("/user/{userId}")
    public List<CarBookingShowDto> getBookingsByUserId(@PathVariable Long userId) {
        List<CarBookingShowDto> bookings = carBookingService.getBookingsByUserId(userId);
        return bookings;
    }

}
