package com.springboot.rentacar.repository;

import com.springboot.rentacar.entity.RentalTypes;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RentalTypesRepo extends JpaRepository<RentalTypes, Integer> {
}
