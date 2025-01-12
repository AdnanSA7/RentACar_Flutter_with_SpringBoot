package com.springboot.rentacar.service;

import com.springboot.rentacar.dto.CarShowDto;
import com.springboot.rentacar.dto.CarsAvailableDto;
import com.springboot.rentacar.entity.Cars;
import com.springboot.rentacar.entity.RentalTypes;
import com.springboot.rentacar.repository.CarCategoryRepo;
import com.springboot.rentacar.repository.CarsRepo;
import com.springboot.rentacar.repository.RentalTypesRepo;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class CarsService {
    @Autowired
    private CarsRepo carsRepo;

    @Autowired
    private CarCategoryRepo carCategoryRepo;

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private RentalTypesRepo rentalTypesRepo;

    @Autowired
    private CarsRepo carRepository;

    public Cars addCar(Cars cars){
        return carsRepo.save(cars);
    }

    public List<CarShowDto> getCars(){
        List<Cars> cars = carsRepo.findAll();
//        List<Cars> cars = carRepository.findAllWithRentalTypes();
        modelMapper.typeMap(Cars.class, CarShowDto.class).addMappings(mapping-> {
            mapping.map(source -> source.getCarCategory().getCategory_name(),CarShowDto::setCategoryName);
//            mapping.map(src -> src.getRentalTypes() != null
//                            ? src.getRentalTypes().stream()
//                            .map(RentalTypes::getServiceName) // Map each RentalTypes object to its name
//                            .collect(Collectors.toList())
//                            : List.of(),
//                    CarShowDto::setRentalTypeName);
        });
        return cars.stream().map(carsShow ->{
            CarShowDto carShowDto = modelMapper.map(carsShow,CarShowDto.class);
            carShowDto.setRentalTypeName(carsShow.getRentalTypes().stream().
                    map(RentalTypes::getRentalType_name).collect(Collectors.toList()));
            return carShowDto;
                }
        ).toList();
    }

    public Optional<Cars> findCar(long id){
        return carsRepo.findById(id);
    }


    /**
     * Get list of available cars based on rental type, car category, and journey start date.
     */
    public List<CarsAvailableDto> getAvailableCars(String rentalTypeName, String categoryName, Date startDate) {
        List<Cars> availableCars = carsRepo.findAvailableCars(rentalTypeName, categoryName, startDate);


        return availableCars.stream().map(cars -> {
            CarsAvailableDto carsAvailableDto = new CarsAvailableDto();
            carsAvailableDto.setId(cars.getId());
            carsAvailableDto.setBrand(cars.getBrand());
            carsAvailableDto.setModel(cars.getModel());
            carsAvailableDto.setCarImage(cars.getCarImage());
            carsAvailableDto.setCategoryName(cars.getCarCategory().getCategory_name());
            carsAvailableDto.setRentalTypeName(rentalTypeName);

            // Extract the service rate for the selected rental type
            double serviceRate = cars.getRentalTypes().stream()
                    .filter(rt -> rt.getRentalType_name().equalsIgnoreCase(rentalTypeName))
                    .findFirst()
                    .map(RentalTypes::getServiceRate)
                    .orElse(0.0); // Default to 0 if no match found

            carsAvailableDto.setServiceRate(serviceRate);
            return carsAvailableDto;
        }).collect(Collectors.toList());
    }


    public void deleteCar(long id){
        carsRepo.deleteById(id);
    }

}
