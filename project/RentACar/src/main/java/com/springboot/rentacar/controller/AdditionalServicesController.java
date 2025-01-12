package com.springboot.rentacar.controller;

import com.springboot.rentacar.dto.AdditionalServicesDto;
import com.springboot.rentacar.service.AdditionalServicesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("api/additionalServices")
@CrossOrigin("*")
public class AdditionalServicesController {

    @Autowired
    private AdditionalServicesService additionalServicesService;

    @GetMapping
    public List<AdditionalServicesDto> getAll(){
        return additionalServicesService.getAllAdditionalServices();
    }
}
