package com.springboot.rentacar.controller;

import com.springboot.rentacar.dto.UserDto;
import com.springboot.rentacar.dto.UserLoginDto;
import com.springboot.rentacar.entity.Users;
import com.springboot.rentacar.repository.UsersRepo;
import com.springboot.rentacar.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api")
@CrossOrigin("*")
public class UsersController {

    @Autowired
    private UsersService usersService;

    @GetMapping
    public List<UserDto> getAllUsers() {
        return usersService.getAllUsers();
    }

    @PostMapping
    public Users createUser(@RequestBody Users user) {
        return usersService.save(user);
    }

    @GetMapping("login")
    public UserLoginDto findUser(@RequestParam String username,@RequestParam String password){
        return usersService.findUser(username, password);
    }

    @GetMapping("user/{id}")
    public UserDto findUserById(@PathVariable Long id) {
        return usersService.findById(id);
    }

}
