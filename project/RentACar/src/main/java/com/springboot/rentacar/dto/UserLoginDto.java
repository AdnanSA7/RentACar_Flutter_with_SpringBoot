package com.springboot.rentacar.dto;

import lombok.Data;

@Data
public class UserLoginDto {
    private long id;
    private String firstName;
    private String lastName;
    private String role;
}
