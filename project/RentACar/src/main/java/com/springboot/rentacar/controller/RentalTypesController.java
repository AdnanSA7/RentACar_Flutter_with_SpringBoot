package com.springboot.rentacar.controller;

import com.springboot.rentacar.dto.RentalTypesDto;
import com.springboot.rentacar.service.RentalTypesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("api/rentType")
@CrossOrigin("*")
public class RentalTypesController {

    @Autowired
    private RentalTypesService rentalTypesService;

    @GetMapping
    public List<RentalTypesDto> getAllRentalTypes() {
        return rentalTypesService.getAll();
    }

}
