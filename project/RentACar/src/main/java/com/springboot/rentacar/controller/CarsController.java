package com.springboot.rentacar.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.springboot.rentacar.dto.CarDto;
import com.springboot.rentacar.dto.CarShowDto;
import com.springboot.rentacar.dto.CarsAvailableDto;
import com.springboot.rentacar.entity.CarCategory;
import com.springboot.rentacar.entity.Cars;
import com.springboot.rentacar.entity.RentalTypes;
import com.springboot.rentacar.repository.CarCategoryRepo;
import com.springboot.rentacar.repository.RentalTypesRepo;
import com.springboot.rentacar.service.CarsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("api/car")
@CrossOrigin("*")
public class CarsController {

    @Autowired
    private CarsService carsService;

    @Autowired
    private CarCategoryRepo carCategoryRepo;

    @Autowired
    private RentalTypesRepo rentalTypesRepo;

    @GetMapping
    public List<CarShowDto> getAllCar(){
        return carsService.getCars();
    }


    @PostMapping(consumes = "multipart/form-data")
    public ResponseEntity<String> addCar(
            @RequestPart("car") String carJson,
            @RequestPart("image") MultipartFile carImage) {

        try {
            // Convert JSON string to CarDto object
            ObjectMapper objectMapper = new ObjectMapper();
            CarDto carDto = objectMapper.readValue(carJson, CarDto.class);

            CarCategory carCategory = carCategoryRepo.findById(carDto.getCarCategoryId()).get();
            List<RentalTypes> rentalTypes = rentalTypesRepo.findAllById(carDto.getRentalTypeIds());

            // Map CarDto to Cars entity
            Cars car = Cars.builder()
                    .brand(carDto.getBrand())
                    .model(carDto.getModel())
                    .year(carDto.getYear())
                    .seats(carDto.getSeats())
                    .color(carDto.getColor())
                    .registrationNumber(carDto.getRegistrationNumber())
                    .carImage(carImage.getBytes()) // Save image bytes
                    .carCategory(carCategory)
                    .rentalTypes(rentalTypes)
                    .build();

            carsService.addCar(car);
            return new ResponseEntity<>("Car added successfully!", HttpStatus.CREATED);

        } catch (IOException e) {
            return new ResponseEntity<>("Error processing the request.", HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("{id}")
    public Optional<Cars> findById(@PathVariable long id){
        return carsService.findCar(id);
    }


    @GetMapping("/available")
    public ResponseEntity<List<CarsAvailableDto>> getAvailableCars(
            @RequestParam String rentalTypeName,
            @RequestParam String categoryName,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date startDate) {
        List<CarsAvailableDto> availableCars = carsService.getAvailableCars(rentalTypeName, categoryName, startDate);
        return ResponseEntity.ok(availableCars);
    }


    @DeleteMapping("{id}")
    public void deleteCar(@PathVariable long id){
        carsService.deleteCar(id);
    }

}
