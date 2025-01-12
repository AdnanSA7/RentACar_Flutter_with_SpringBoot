package com.springboot.rentacar.repository;

import com.springboot.rentacar.entity.AdditionalService;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AdditionalServiceRepo extends JpaRepository<AdditionalService, Integer> {
}
