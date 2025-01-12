package com.springboot.rentacar.service;

import com.springboot.rentacar.dto.CarCategoryDto;
import com.springboot.rentacar.entity.CarCategory;
import com.springboot.rentacar.repository.CarCategoryRepo;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class CarCategoryService {

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private CarCategoryRepo carCategoryRepo;

    public List<CarCategoryDto> findAll() {
        List<CarCategory> carCategory = carCategoryRepo.findAll();
        return carCategory.stream().map(carCategory1 ->
                modelMapper.map(carCategory1, CarCategoryDto.class)).collect(Collectors.toList());
    }

    public CarCategory findById(int id) {
        return carCategoryRepo.findById(id).get();
    }

    public CarCategory save(CarCategory carCategory) {
        return carCategoryRepo.save(carCategory);
    }

    public void deleteById(int id) {
        carCategoryRepo.deleteById(id);
    }

    public CarCategory update(CarCategory carCategory) {
        CarCategory oldCarCategory = carCategoryRepo.findById(carCategory.getId()).get();
        oldCarCategory.setCategory_name(carCategory.getCategory_name());
        return carCategoryRepo.save(carCategory);
    }

}
