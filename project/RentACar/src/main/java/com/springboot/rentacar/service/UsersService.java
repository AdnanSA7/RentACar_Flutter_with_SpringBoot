package com.springboot.rentacar.service;

import com.springboot.rentacar.dto.UserDto;
import com.springboot.rentacar.dto.UserLoginDto;
import com.springboot.rentacar.entity.Users;
import com.springboot.rentacar.enums.UserRole;
import com.springboot.rentacar.repository.UsersRepo;
import com.springboot.rentacar.repository.CarsRepo;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class UsersService {

    @Autowired
    private UsersRepo usersRepo;

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private CarsRepo carsRepo;

    public List<UserDto> getAllUsers() {
        List<Users> users = usersRepo.findAll();
        return users.stream().map(user -> modelMapper.map(user, UserDto.class)).collect(Collectors.toList());
    }

    public Users save(Users users) {
        users.setRole(UserRole.CUSTOMER);
        return usersRepo.save(users);
    }

    public UserDto findById(long id) {
        Users user = usersRepo.findById(id).get();
        return modelMapper.map(user, UserDto.class);
    }

    public UserLoginDto findUser(String username, String password){
        Users user = usersRepo.findByUsernameAndPassword(username, password);
        return modelMapper.map(user, UserLoginDto.class);
    }




//    public List<Category> findAll() {
//        return usersRepo.findAll();
//    }
//
//    public Category findById(long id) {
//        return usersRepo.findById(id).get();
//    }
//
//    public Product save(Product product) {
//        return carsRepo.save(product);
//    }

//    public Category findByCategoryName(String categoryName) {
//        return  categoryRepo.findByCategoryName(categoryName);
//    }
}
