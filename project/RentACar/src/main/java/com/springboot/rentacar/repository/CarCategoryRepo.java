package com.springboot.rentacar.repository;

import com.springboot.rentacar.entity.CarCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CarCategoryRepo extends JpaRepository<CarCategory, Integer> {
}
