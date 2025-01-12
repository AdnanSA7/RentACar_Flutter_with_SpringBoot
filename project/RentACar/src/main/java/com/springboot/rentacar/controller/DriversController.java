package com.springboot.rentacar.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.springboot.rentacar.dto.DriverDto;
import com.springboot.rentacar.dto.DriverShowDto;
import com.springboot.rentacar.entity.Drivers;
import com.springboot.rentacar.service.DriversService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("api/driver")
@CrossOrigin("*")
public class DriversController {

    @Autowired
    private DriversService driversService;

    @GetMapping
    public List<DriverShowDto> getAllDrivers() {
        return driversService.getAllDrivers();
    }

    @PostMapping(consumes = "multipart/form-data")
    public ResponseEntity<String> createDriver(
            @RequestPart("driverData") String driverInfo,
            @RequestPart("driverImage") MultipartFile driverImage
    ) throws IOException {

        ObjectMapper mapper = new ObjectMapper();
        DriverDto driverDto = mapper.readValue(driverInfo, DriverDto.class);

        // Create the driver using the service
        driversService.addDriver(driverDto,driverImage);

        return ResponseEntity.ok("Driver added successfully");
    }

}
