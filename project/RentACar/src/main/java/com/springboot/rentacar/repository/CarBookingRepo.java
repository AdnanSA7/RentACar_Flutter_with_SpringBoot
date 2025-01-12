package com.springboot.rentacar.repository;

import com.springboot.rentacar.entity.CarBooking;
import com.springboot.rentacar.entity.Cars;
import com.springboot.rentacar.enums.ServiceAction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface CarBookingRepo extends JpaRepository<CarBooking,Long> {

    List<CarBooking> findByCarAndStatus(Cars car, ServiceAction status);

    @Query("SELECT cb FROM CarBooking cb WHERE cb.user.id = :userId")
    List<CarBooking> findBookingsByUserId(@Param("userId") Long userId);


    // Check if the event's date is before the given date
    @Query("SELECT e FROM CarBooking e WHERE e.endDate < :currentDate")
    List<CarBooking> findEventsBeforeDate(LocalDate currentDate);

}
