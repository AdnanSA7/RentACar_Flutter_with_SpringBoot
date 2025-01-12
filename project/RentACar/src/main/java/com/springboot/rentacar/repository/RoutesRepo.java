package com.springboot.rentacar.repository;

import com.springboot.rentacar.entity.Routes;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RoutesRepo extends JpaRepository<Routes, Integer> {
    Optional<Routes> findByStartLocationAndEndLocation(String startLocation, String endLocation);
}
