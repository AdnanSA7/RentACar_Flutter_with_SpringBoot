package com.springboot.rentacar.repository;

import com.springboot.rentacar.entity.Drivers;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DriversRepo extends JpaRepository<Drivers, Long> {
}
