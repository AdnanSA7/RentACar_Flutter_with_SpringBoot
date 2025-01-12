package com.springboot.rentacar.controller;

import com.springboot.rentacar.service.RoutesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/routes")
public class RoutesController {

    @Autowired
    private RoutesService routesService;

    @GetMapping("/distance")
    public ResponseEntity<Double> getRouteDistance(
            @RequestParam String startLocation,
            @RequestParam String endLocation
    ) {
        double distance = routesService.getRouteDistance(startLocation, endLocation);
        return ResponseEntity.ok(distance);
    }

}
