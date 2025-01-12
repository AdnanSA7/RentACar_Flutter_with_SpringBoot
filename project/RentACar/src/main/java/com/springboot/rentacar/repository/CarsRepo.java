package com.springboot.rentacar.repository;

import com.springboot.rentacar.entity.Cars;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface CarsRepo extends JpaRepository<Cars, Long> {

//    @Query("SELECT c FROM Cars c LEFT JOIN FETCH c.rentalTypes WHERE c.id = :id")
//    Cars findByIdWithRentalTypes(@Param("id") Long id);

//    @Query("SELECT DISTINCT c FROM Cars c LEFT JOIN FETCH c.rentalTypes")
//    List<Cars> findAllWithRentalTypes();

//    @Query("SELECT c FROM Cars c " +
//            "JOIN c.rentalTypes rt " +
//            "JOIN c.carCategory cc " +
//            "WHERE rt.rentalType_name = :rentalTypeName " +
//            "AND cc.category_name = :categoryName " +
//            "AND c.id NOT IN (" +
//            "   SELECT b.car.id FROM CarBooking b " +
//            "   WHERE :startDate BETWEEN b.startDate AND b.endDate " +
//            ")")
//    List<Cars> findAvailableCars(@Param("rentalTypeName") String rentalTypeName,
//                                 @Param("categoryName") String categoryName,
//                                 @Param("startDate") Date startDate);

//    @Query("SELECT c FROM Cars c " +
//            "JOIN c.rentalTypes rt " +
//            "JOIN c.carCategory cc " +
//            "WHERE rt.rentalType_name = :rentalTypeName " +
//            "AND cc.category_name = :categoryName " +
//            "AND c.id NOT IN (" +
//            "   SELECT b.car.id FROM CarBooking b " +
//            "   WHERE :startDate BETWEEN b.startDate AND b.endDate " +
//            "   AND b.status != 'Rented'" +  // Exclude bookings with 'Rented' status (as string)
//            ")")
//    List<Cars> findAvailableCars(@Param("rentalTypeName") String rentalTypeName,
//                                 @Param("categoryName") String categoryName,
//                                 @Param("startDate") Date startDate);


    @Query("SELECT c FROM Cars c " +
            "JOIN c.rentalTypes rt " +
            "JOIN c.carCategory cc " +
            "LEFT JOIN c.driver d " + // Ensure drivers are assigned
            "WHERE rt.rentalType_name = :rentalTypeName " +
            "AND cc.category_name = :categoryName " +
            "AND d IS NOT NULL " + // Exclude cars without assigned drivers
            "AND c.id NOT IN (" +
            "   SELECT b.car.id FROM CarBooking b " +
            "   WHERE :startDate BETWEEN b.startDate AND b.endDate " +
            "   AND b.status = com.springboot.rentacar.enums.ServiceAction.Rented " + // Fully qualified enum name
            ")")
    List<Cars> findAvailableCars(@Param("rentalTypeName") String rentalTypeName,
                                 @Param("categoryName") String categoryName,
                                 @Param("startDate") Date startDate);


}
