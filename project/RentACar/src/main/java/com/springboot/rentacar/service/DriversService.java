package com.springboot.rentacar.service;

import com.springboot.rentacar.dto.DriverDto;
import com.springboot.rentacar.dto.DriverShowDto;
import com.springboot.rentacar.entity.Cars;
import com.springboot.rentacar.entity.Drivers;
import com.springboot.rentacar.repository.CarsRepo;
import com.springboot.rentacar.repository.DriversRepo;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class DriversService {

    @Autowired
    private DriversRepo driversRepo;

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private CarsRepo carsRepo;

    public List<DriverShowDto> getAllDrivers() {
        List<Drivers> drivers = driversRepo.findAll();
        modelMapper.typeMap(Drivers.class, DriverShowDto.class).addMappings(mapping ->
                mapping.map(source -> source.getCar().getId(), DriverShowDto::setCarId));

        return drivers.stream().map(drivers1 ->
                modelMapper.map(drivers1, DriverShowDto.class)).collect(Collectors.toList());
    }


    public Drivers getDriverById(long id) {
        return driversRepo.findById(id).get();
    }

    public Drivers updateDriver(Drivers driver) {
        Drivers oldDriver = driversRepo.findById(driver.getId()).get();
        oldDriver.setFirstName(driver.getFirstName());
        oldDriver.setLastName(driver.getLastName());
        return driversRepo.save(driver);
    }

    public Drivers addDriver(DriverDto driverData, MultipartFile driverImage) throws IOException {
        // Find the car by ID
        Cars car = carsRepo.findById(driverData.getCarId())
                .orElseThrow(() -> new RuntimeException("Car not found with ID: " + driverData.getCarId()));

        // Create the driver entity
        Drivers driver = Drivers.builder()
                .firstName(driverData.getFirstName())
                .lastName(driverData.getLastName())
                .number(driverData.getNumber())
                .nid_number(driverData.getNidNumber())
                .driverImage(driverImage.getBytes())
                .drivingLicenseNum(driverData.getDrivingLicenseNum())
                .car(car)
                .build();

        // Save the driver entity
        return driversRepo.save(driver);
    }
}
