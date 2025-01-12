package com.springboot.rentacar.service;

import com.springboot.rentacar.dto.AdditionalServicesDto;
import com.springboot.rentacar.entity.AdditionalService;
import com.springboot.rentacar.repository.AdditionalServiceRepo;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class AdditionalServicesService {

    @Autowired
    private AdditionalServiceRepo additionalServiceRepo;

    @Autowired
    private ModelMapper modelMapper;

    public List<AdditionalServicesDto> getAllAdditionalServices(){
        List<AdditionalService> additionalService = additionalServiceRepo.findAll();

        return additionalService.stream().map(additionalService1 ->
                modelMapper.map(additionalService1, AdditionalServicesDto.class)).collect(Collectors.toList());
    }
}
