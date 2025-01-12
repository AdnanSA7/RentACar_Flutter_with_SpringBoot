package com.springboot.rentacar.service;

import com.springboot.rentacar.dto.RentalTypesDto;
import com.springboot.rentacar.entity.Cars;
import com.springboot.rentacar.entity.RentalTypes;
import com.springboot.rentacar.repository.RentalTypesRepo;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class RentalTypesService {

    @Autowired
    private RentalTypesRepo rentalTypesRepo;

    @Autowired
    private ModelMapper modelMapper;

    public RentalTypes addRentalTypes(RentalTypes rentalTypes){
        return rentalTypesRepo.save(rentalTypes);
    }

    public List<RentalTypesDto> getAll(){
        List<RentalTypes> rentalTypes = rentalTypesRepo.findAll();

//        modelMapper.typeMap( RentalTypes.class,RentalTypesDto.class).addMappings(mapper -> {
//            mapper.map(src-> src.getCars().get().getCarCategory().getCategory_name(),RentalTypesDto::setCategoryName);
//        });

        return rentalTypes.stream()
                .map(rentalType -> {
                    RentalTypesDto dto = modelMapper.map(rentalType, RentalTypesDto.class);

                    // Extract carCategoryNames from the list of cars
                    List<String> carCategoryNames = rentalType.getCars().stream()
                            .map(car -> car.getCarCategory().getCategory_name())
                            .distinct() // Avoid duplicate category names
                            .collect(Collectors.toList());

                    dto.setCarCategoryNames(carCategoryNames);
                    return dto;
                })
                .collect(Collectors.toList());

//
//        return rentalTypes.stream().map(rentalTypes1 ->
//                modelMapper.map(rentalTypes1, RentalTypesDto.class)).collect(Collectors.toList());
    }

    public Optional<RentalTypes> findById(RentalTypes rentalTypes){
        return rentalTypesRepo.findById(rentalTypes.getId());
    }

    public void delete(int id){
        rentalTypesRepo.deleteById(id);
    }

    public RentalTypes update(RentalTypes rentalTypes){
        RentalTypes previousType = rentalTypesRepo.findById(rentalTypes.getId()).get();
        previousType.setRentalType_name(rentalTypes.getRentalType_name());
        previousType.setServiceRate(rentalTypes.getServiceRate());
        return rentalTypesRepo.save(previousType);
    }

    public RentalTypes updateRentalType(int id, RentalTypes updatedRentalType) {
        return rentalTypesRepo.findById(id)
                .map(existingRentalType -> {
                    existingRentalType.setRentalType_name(updatedRentalType.getRentalType_name());
                    existingRentalType.setServiceRate(updatedRentalType.getServiceRate());
                    return rentalTypesRepo.save(existingRentalType);
                })
                .orElseThrow(() -> new RuntimeException("RentalType not found with id: " + id));
    }
}
