package com.springboot.rentacar.service;

import com.springboot.rentacar.entity.Routes;
import com.springboot.rentacar.repository.RoutesRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RoutesService {

    @Autowired
    private RoutesRepo routesRepo;

    public double getRouteDistance(String startLocation, String endLocation) {
        return routesRepo.findByStartLocationAndEndLocation(startLocation, endLocation)
                .map(Routes::getDistance)
                .orElseThrow(() -> new RuntimeException("Route not found"));
    }
}
