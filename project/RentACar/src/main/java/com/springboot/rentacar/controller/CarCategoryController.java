package com.springboot.rentacar.controller;

import com.springboot.rentacar.dto.CarCategoryDto;
import com.springboot.rentacar.entity.CarCategory;
import com.springboot.rentacar.service.CarCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/carCategory")
@CrossOrigin("*")
public class CarCategoryController {

    @Autowired
    private CarCategoryService carCategoryService;

    @GetMapping
    public List<CarCategoryDto> getAllCarCategory() {
        return carCategoryService.findAll();
    }

    @GetMapping("{id}")
    public CarCategory getCarCategoryById(@PathVariable int id) {
        return carCategoryService.findById(id);
    }

    @PostMapping
    public CarCategory addCarCategory(@RequestBody CarCategory carCategory){
        return carCategoryService.save(carCategory);
    }

    @DeleteMapping("{id}")
    public void deleteCarCategoryById(@PathVariable int id) {
        carCategoryService.deleteById(id);
    }


}
