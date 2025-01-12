package com.springboot.rentacar.dto;

import lombok.Data;

@Data
public class UserDto {
    private long id;
    private String firstName;
    private String lastName;
    private String email;
    private String role;
    private String phone;
}
