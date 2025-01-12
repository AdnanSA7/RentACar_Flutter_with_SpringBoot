package com.springboot.rentacar.repository;

import com.springboot.rentacar.entity.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface UsersRepo extends JpaRepository<Users, Long> {
//    @Query("select id from Category where category_name = ?")
//    Category findByCategoryName(String category_name);
//    Category findCategoryByCategory_name(String category_name);
    Users findByUsernameAndPassword(String username, String password);

}
