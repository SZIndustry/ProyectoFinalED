package com.final_proyect.app.controller;

import org.springframework.web.bind.annotation.*;

import java.util.*;

@CrossOrigin(origins = "*")
@RestController
public class Example {

    @GetMapping("/")
    public String hello() {
        return "Hola desde Spring Boot!";
    }

    @PostMapping("/send-data")
    public String receiveData(@RequestBody Map<String, Object> data) {
        System.out.println("Datos recibidos: " + data);
        return "Datos recibidos correctamente!";
    }
}