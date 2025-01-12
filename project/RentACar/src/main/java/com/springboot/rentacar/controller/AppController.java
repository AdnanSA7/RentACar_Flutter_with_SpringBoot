//package com.springboot.rentacar.controller;
//
//import jakarta.servlet.http.HttpServletRequest;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.security.web.csrf.CsrfToken;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RestController;
//
//@RestController
//public class AppController {
//
//    @GetMapping("/show")
//    public String show(){
//        return "Hello World!!!";
//    }
//
//    @GetMapping("/csrftoken")
//    public CsrfToken getCsrfToken(HttpServletRequest request) {
//        return (CsrfToken) request.getAttribute("_csrf");
//    }
//
//}
