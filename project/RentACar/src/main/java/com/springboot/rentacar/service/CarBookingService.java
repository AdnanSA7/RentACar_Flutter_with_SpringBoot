package com.springboot.rentacar.service;

import com.springboot.rentacar.dto.CarBookingRequestDto;
import com.springboot.rentacar.dto.CarBookingShowDto;
import com.springboot.rentacar.entity.*;
import com.springboot.rentacar.enums.ServiceAction;
import com.springboot.rentacar.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class CarBookingService {

    @Autowired
    private CarBookingRepo carBookingRepo;

    @Autowired
    private UsersRepo usersRepo;

    @Autowired
    private CarsRepo carsRepo;

    @Autowired
    private AdditionalServiceRepo additionalServiceRepo;

    @Autowired
    private PaymentRepo paymentRepo;

    @Autowired
    private DriversRepo driversRepo;


//    private CarBookingShow mapToCarBookingShow(CarBooking carBooking) {
//        CarBookingShow dto = new CarBookingShow();
//        dto.setCarId(carBooking.getCar().getId());
//        dto.setRentalType(carBooking.getRentalType());
//        dto.setStartDate(carBooking.getStartDate());
//        dto.setEndDate(carBooking.getEndDate());
//        dto.setPickupLocation(carBooking.getPickup_location());
//        dto.setDropOffLocation(carBooking.getDropOff_location());
//        dto.setHours(carBooking.getHours());
//        dto.setDistance(carBooking.getDistance());
//        dto.setCost(carBooking.getCost());
//        dto.setStatus(carBooking.getStatus());
//
//        // Map driver details
//        if (carBooking.getDriver() != null) {
//            dto.setDriverId(carBooking.getDriver().getId());
//            dto.setDriverFirstName(carBooking.getDriver().getFirstName());
//            dto.setDriverLastName(carBooking.getDriver().getLastName());
//        }
//
//        // Map additional services
//        if (carBooking.getAdditionalService() != null) {
//            List<String> additionalServiceNames = carBooking.getAdditionalService()
//                    .stream()
//                    .map(AdditionalService::getName) // Assuming `getServiceName()` exists in `AdditionalService`
//                    .collect(Collectors.toList());
//            dto.setAdditionalServiceName(additionalServiceNames);
//        }
//
//        return dto;
//    }


//    private CarBookingShow mapToCarBookingShow(CarBooking carBooking) {
//        CarBookingShow dto = new CarBookingShow();
//        dto.setCarId(carBooking.getCar().getId());
//        dto.setRentalType(carBooking.getRentalType());
//        dto.setStartDate(carBooking.getStartDate());
//        dto.setEndDate(carBooking.getEndDate());
//        dto.setPickupLocation(carBooking.getPickup_location());
//        dto.setDropOffLocation(carBooking.getDropOff_location());
//        dto.setHours(carBooking.getHours());
//        dto.setDistance(carBooking.getDistance());
//        dto.setCost(carBooking.getCost());
//        dto.setStatus(carBooking.getStatus());
//
//        // Map driver details
//        if (carBooking.getDriver() != null) {
//            dto.setDriverId(carBooking.getDriver().getId());
//            dto.setDriverFirstName(carBooking.getDriver().getFirstName());
//            dto.setDriverLastName(carBooking.getDriver().getLastName());
//        }
//
//        // Map additional services
//        if (carBooking.getAdditionalService() != null) {
//            List<String> additionalServiceNames = carBooking.getAdditionalService()
//                    .stream()
//                    .map(AdditionalService::getName) // Assuming `getServiceName()` exists in `AdditionalService`
//                    .collect(Collectors.toList());
//            dto.setAdditionalServiceName(additionalServiceNames);
//        }
//
//        // Map Payment details (if exists)
//        Payment payment = carBooking.getPayment(); // Assuming CarBooking has a `Payment` relationship
//        if (payment != null) {
//            dto.setPaymentAmount(payment.getAmount());
//            dto.setPaymentDate(payment.getPayment_date());
//            dto.setPaymentStatus(payment.isPayment_status());
//            dto.setPaymentMethod(payment.getPayment_method());
//        }
//
//        return dto;
//    }




    /**
     * Book a car dynamically based on rental type.
     */
//    public CarBooking bookCar(CarBookingRequestDto bookingRequest) {
//        // Fetch Car entity
//        Cars car = carsRepo.findById(bookingRequest.getCarId())
//                .orElseThrow(() -> new RuntimeException("Car not found"));
//
//        // Calculate cost dynamically
//        double cost = calculateCost(bookingRequest, car);
//
//        // Fetch additional services
//        List<AdditionalService> additionalServices = additionalServiceRepo
//                .findAllById(bookingRequest.getAdditionalServiceIds());
//
//        // Create CarBooking entity
//        CarBooking booking = new CarBooking();
//        booking.setCar(car);
//        booking.setStartDate(bookingRequest.getStartDate());
//        booking.setEndDate(bookingRequest.getEndDate());
//        booking.setPickup_location(bookingRequest.getPickupLocation());
//        booking.setDropOff_location(bookingRequest.getDropOffLocation());
//        booking.setRentalType(bookingRequest.getRentalType());
//        booking.setCost(cost);
//        booking.setAdditionalService(additionalServices);
//        booking.setStatus(null);
//
//        return carBookingRepo.save(booking);
//    }


//    public CarBookingShow bookCar(CarBookingRequestDto bookingRequest) {
//        // Fetch Car entity
//        Cars car = carsRepo.findById(bookingRequest.getCarId())
//                .orElseThrow(() -> new RuntimeException("Car not found"));
//
//        // Calculate cost dynamically
//        double cost = calculateCost(bookingRequest, car);
//
//        // Fetch additional services
//        List<AdditionalService> additionalServices = additionalServiceRepo
//                .findAllById(bookingRequest.getAdditionalServiceIds());
//
//        // Create CarBooking entity
//        CarBooking booking = new CarBooking();
//        booking.setCar(car);
//        booking.setStartDate(bookingRequest.getStartDate());
//        booking.setEndDate(bookingRequest.getEndDate());
//        booking.setPickup_location(bookingRequest.getPickupLocation());
//        booking.setDropOff_location(bookingRequest.getDropOffLocation());
//        booking.setRentalType(bookingRequest.getRentalType());
//        booking.setCost(cost);
//        booking.setAdditionalService(additionalServices);
//        booking.setStatus(null);
//
//        // Save the booking
//        CarBooking savedBooking = carBookingRepo.save(booking);
//
//        // Map to DTO and return
//        return mapToCarBookingShow(savedBooking);
//    }


//    public CarBookingShow bookCar(CarBookingRequestDto bookingRequest) {
//        // Fetch Car entity
//        Cars car = carsRepo.findById(bookingRequest.getCarId())
//                .orElseThrow(() -> new RuntimeException("Car not found"));
//
//        // Calculate cost dynamically
//        double cost = calculateCost(bookingRequest, car);
//
//        // Fetch additional services
//        List<AdditionalService> additionalServices = additionalServiceRepo
//                .findAllById(bookingRequest.getAdditionalServiceIds());
//
//        // Create CarBooking entity
//        CarBooking booking = new CarBooking();
//        booking.setCar(car);
//        booking.setStartDate(bookingRequest.getStartDate());
//        booking.setEndDate(bookingRequest.getEndDate());
//        booking.setPickup_location(bookingRequest.getPickupLocation());
//        booking.setDropOff_location(bookingRequest.getDropOffLocation());
//        booking.setRentalType(bookingRequest.getRentalType());
//        booking.setCost(cost);
//        booking.setAdditionalService(additionalServices);
//        booking.setStatus(null);
//
//        // Create and associate payment
//        Payment payment = new Payment();
//        payment.setAmount(cost);
//        payment.setPayment_date(new Date());  // Assume payment is done immediately
//        payment.setPayment_status(true); // Set to true, assuming successful payment
//        payment.setPayment_method(bookingRequest.getPaymentMethod()); // Use payment method from the request
//        payment.setCarBooking(booking); // Associate payment with booking
//
//        // Save Payment and CarBooking
//        paymentRepo.save(payment);
//        booking.setPayment(payment); // Set payment to the CarBooking
//
//        // Save the booking
//        CarBooking savedBooking = carBookingRepo.save(booking);
//
//        // Map to DTO and return
//        return mapToCarBookingShow(savedBooking);
//    }


    /**
     * Create a booking and return detailed booking information.
     */
    public CarBookingShowDto createBookingAndGetDetails(CarBookingRequestDto requestDto) {
        // Step 1: Validate Car Availability
        Cars car = carsRepo.findById(requestDto.getCarId())
                .orElseThrow(() -> new RuntimeException("Car not found"));

//        if (isCarAlreadyBooked(car, requestDto.getStartDate(), requestDto.getEndDate())) {
//            throw new RuntimeException("Car is not available for the selected dates.");
//        }

        // Step 2: Fetch User and Driver
        Users user = usersRepo.findById(requestDto.getUserId())
                .orElseThrow(() -> new RuntimeException("User not found"));
        Drivers driver = driversRepo.findById(car.getDriver().getId())
                .orElseThrow(() -> new RuntimeException("Driver not found"));


        // Step 3: Fetch Additional Services
        List<AdditionalService> additionalServices = additionalServiceRepo.findAllById(requestDto.getAdditionalServiceIds());

        // Step 4: Calculate Cost
        double cost = calculateCost(requestDto, car, additionalServices);

        // Step 5: Adjust `endDate` if rental type is "hourly"
        if ("hourly".equalsIgnoreCase(requestDto.getRentalType())) {
            if (requestDto.getHours() == null || requestDto.getHours() <= 0) {
                throw new RuntimeException("Hours must be specified for hourly rental.");
            }
            // Add hours to the start date to calculate the end date
            Date probableEndDate = new Date(requestDto.getStartDate().getTime() + requestDto.getHours() * 60L * 60 * 1000);
            requestDto.setEndDate(probableEndDate);
        }

        // Step 6: Create Booking
        CarBooking booking = new CarBooking();
        booking.setCar(car);
        booking.setRentalType(requestDto.getRentalType());
        booking.setStartDate(requestDto.getStartDate());
        booking.setEndDate(requestDto.getEndDate());
        booking.setPickup_location(requestDto.getPickupLocation());
        booking.setDropOff_location(requestDto.getDropOffLocation());
        booking.setHours(requestDto.getHours());
        booking.setDistance(requestDto.getDistance());
        booking.setCost(cost);
        booking.setUser(user);
        booking.setDriver(driver);
        booking.setStatus(ServiceAction.Pending); // Initially Pending
        booking.setAdminApproval(false); // Pending Admin Approval
        booking.setServiceStart(false); // Pending Driver Approval
        booking.setAdditionalService(additionalServices);

        CarBooking savedBooking = carBookingRepo.save(booking);

        // Step 7: Map to CarBookingShowDto
        return mapToCarBookingShowDto(savedBooking);
    }

    private boolean isCarAlreadyBooked(Cars car, Date startDate, Date endDate) {
        List<CarBooking> existingBookings = carBookingRepo.findByCarAndStatus(car, ServiceAction.Rented);
        for (CarBooking booking : existingBookings) {
            if (booking.getStartDate().before(endDate) && booking.getEndDate().after(startDate)) {
                return true; // Overlap exists
            }
        }
        return false;
    }

    private double calculateCost(CarBookingRequestDto requestDto, Cars car, List<AdditionalService> additionalServices) {
        double baseRate = car.getRentalTypes().stream()
                .filter(rt -> rt.getRentalType_name().equalsIgnoreCase(requestDto.getRentalType()))
                .findFirst()
                .map(RentalTypes::getServiceRate)
                .orElseThrow(() -> new RuntimeException("Rental type not found"));

        double totalCost = 0;

        switch (requestDto.getRentalType().toLowerCase()) {
            case "hourly":
                if (requestDto.getHours() == null || requestDto.getHours() <= 0) {
                    throw new RuntimeException("Hours must be specified for hourly rental.");
                }
                totalCost = baseRate * requestDto.getHours();
                break;

            case "daily":
                long days = (requestDto.getEndDate().getTime() - requestDto.getStartDate().getTime()) / (1000 * 60 * 60 * 24);
                totalCost = baseRate * Math.max(days, 1);
                break;

            case "outstation round trip":
                if (requestDto.getDistance() == null || requestDto.getDistance() <= 0) {
                    throw new RuntimeException("Distance must be specified for outstation round trip.");
                }
                totalCost = baseRate * requestDto.getDistance();
                break;

            default:
                throw new RuntimeException("Invalid rental type.");
        }

        double additionalCost = additionalServices.stream()
                .mapToDouble(AdditionalService::getCost)
                .sum();

        return totalCost + additionalCost;
    }

    private CarBookingShowDto mapToCarBookingShowDto(CarBooking booking) {
        CarBookingShowDto dto = new CarBookingShowDto();
        dto.setId(booking.getId());
        dto.setCarId(booking.getCar() != null ? booking.getCar().getId() : null);
        dto.setRentalType(booking.getRentalType());
        dto.setStartDate(booking.getStartDate());
        dto.setEndDate(booking.getEndDate());
        dto.setPickupLocation(booking.getPickup_location());
        dto.setDropOffLocation(booking.getDropOff_location());
        dto.setHours(booking.getHours());
        dto.setDistance(booking.getDistance());
        dto.setCost(booking.getCost());
        dto.setStatus(booking.getStatus());
        dto.setAdminApproval(booking.getAdminApproval());
        dto.setServiceStart(booking.getServiceStart());

        // Null checks for user
        if (booking.getUser() != null) {
            dto.setUserId(booking.getUser().getId());
            dto.setUserFirstName(booking.getUser().getFirstName());
            dto.setUserLastName(booking.getUser().getLastName());
        } else {
            dto.setUserId(null);
            dto.setUserFirstName(null);
            dto.setUserLastName(null);
        }

        // Null checks for driver
        if (booking.getDriver() != null) {
            dto.setDriverId(booking.getDriver().getId());
            dto.setDriverFirstName(booking.getDriver().getFirstName());
            dto.setDriverLastName(booking.getDriver().getLastName());
        } else {
            dto.setDriverId(null);
            dto.setDriverFirstName(null);
            dto.setDriverLastName(null);
        }

        // Null checks for additional services
        if (booking.getAdditionalService() != null) {
            dto.setAdditionalServiceName(
                    booking.getAdditionalService().stream()
                            .map(AdditionalService::getName)
                            .collect(Collectors.toList())
            );
        } else {
            dto.setAdditionalServiceName(Collections.emptyList());
        }

        return dto;
    }


//    private CarBookingShowDto mapToCarBookingShowDto(CarBooking booking) {
//        CarBookingShowDto dto = new CarBookingShowDto();
//        dto.setCarId(booking.getCar().getId());
//        dto.setRentalType(booking.getRentalType());
//        dto.setStartDate(booking.getStartDate());
//        dto.setEndDate(booking.getEndDate());
//        dto.setPickupLocation(booking.getPickup_location());
//        dto.setDropOffLocation(booking.getDropOff_location());
//        dto.setHours(booking.getHours());
//        dto.setDistance(booking.getDistance());
//        dto.setCost(booking.getCost());
//        dto.setStatus(booking.getStatus());
//        dto.setAdminApproval(booking.getAdminApproval());
//        dto.setServiceStart(booking.getServiceStart());
//        dto.setUserId(booking.getUser() != null ? booking.getUser().getId() : null);
//        dto.setUserFirstName(booking.getUser() != null ? booking.getUser().getFirstName() : null);
//        dto.setUserLastName(booking.getUser() != null ? booking.getUser().getLastName() : null);
//        dto.setDriverId(booking.getDriver() != null ? booking.getDriver().getId() : null);
//        dto.setDriverFirstName(booking.getDriver() != null ? booking.getDriver().getFirstName() : null);
//        dto.setDriverLastName(booking.getDriver() != null ? booking.getDriver().getLastName() : null);
//        dto.setAdditionalServiceName(
//                booking.getAdditionalService().stream()
//                        .map(AdditionalService::getName)
//                        .collect(Collectors.toList())
//        );
//        return dto;
//    }



//    /**
//     * Calculate cost based on rental type.
//     */
//    private double calculateCost(CarBookingRequestDto bookingRequest, Cars car) {
//        switch (bookingRequest.getRentalType().toLowerCase()) {
//            case "hourly":
//                return bookingRequest.getHours() * getServiceRate(car, "Hourly");
//
//            case "daily":
//                long days = ChronoUnit.DAYS.between(
//                        bookingRequest.getStartDate().toInstant(),
//                        bookingRequest.getEndDate().toInstant()
//                );
//                return days * getServiceRate(car, "Daily");
//
//            case "outstation round trip":
//                return bookingRequest.getDistance() * getServiceRate(car, "Outstation Round Trip");
//
//            default:
//                throw new IllegalArgumentException("Invalid rental type: " + bookingRequest.getRentalType());
//        }
//    }
//
//    /**
//     * Helper to get service rate for a rental type.
//     */
//    private double getServiceRate(Cars car, String rentalTypeName) {
//        return car.getRentalTypes().stream()
//                .filter(rt -> rt.getRentalType_name().equalsIgnoreCase(rentalTypeName))
//                .findFirst()
//                .map(RentalTypes::getServiceRate)
//                .orElseThrow(() -> new RuntimeException("Rental type not found for car"));
//    }






//    public CarBooking createBooking(Long userId, Long carId, List<Long> serviceIds, Date startDate, Date endDate) {
//        Optional<Users> userOpt = usersRepo.findById(userId);
//        Optional<Cars> carOpt = carsRepo.findById(carId);
//
//        if (userOpt.isEmpty() || carOpt.isEmpty()) {
//            throw new RuntimeException("User or Car not found");
//        }
//
//        Users user = userOpt.get();
//        Cars car = carOpt.get();
//
//        CarBooking booking = new CarBooking();
//        booking.setUser(user);
//        booking.setCar(car);
//        booking.setStartDate(startDate);
//        booking.setEndDate(endDate);
//
//        // Calculate total cost
////        double rentalCost = car.getRentalPricePerDay() * (endDate.toEpochDay() - startDate.toEpochDay());
//        double rentalCost = 0;
//        double additionalServiceCost = 0;
//
//        for (Integer serviceId : serviceIds) {
//            AdditionalService service = additionalServiceRepo.findById(serviceId)
//                    .orElseThrow(() -> new RuntimeException("Service not found"));
//            booking.getAdditionalService().add(service);
//            additionalServiceCost += service.getCost();
//        }
//
//        booking.setCost(rentalCost + additionalServiceCost);
//
//        return carBookingRepo.save(booking);
//    }


public CarBooking approveBookingByAdmin(Long bookingId, Boolean approval) {
    CarBooking booking = carBookingRepo.findById(bookingId)
            .orElseThrow(() -> new RuntimeException("Booking not found"));

    booking.setAdminApproval(approval);
    carBookingRepo.save(booking);

    return booking;
}


    public CarBooking approveBookingByDriver(Long bookingId, Boolean approval) {
        CarBooking booking = carBookingRepo.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));

        booking.setServiceStart(approval);
        carBookingRepo.save(booking);

        return booking;
    }

    public List<CarBookingShowDto> getBookingsByUserId(Long userId) {
        List<CarBooking> carBookings = carBookingRepo.findBookingsByUserId(userId);
        return carBookings.stream().map(this::mapToCarBookingShowDto).collect(Collectors.toList());
    }


    public List<CarBookingShowDto> getAll(){
        List<CarBooking> carBookings = carBookingRepo.findAll();
        return carBookings.stream().map(this::mapToCarBookingShowDto).collect(Collectors.toList());
    }

    public Optional<CarBooking> findById(CarBooking carBooking){
        return carBookingRepo.findById(carBooking.getId());
    }


    public List<CarBooking> findByDate(LocalDate date){
        return carBookingRepo.findEventsBeforeDate(date);
    }


    public void delete(long id){
        carBookingRepo.deleteById(id);
    }

}
