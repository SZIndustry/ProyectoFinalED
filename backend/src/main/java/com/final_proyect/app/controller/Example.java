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
<<<<<<< HEAD
=======

//prueba
// prueba de github
//prueba 2 github
//prueba 3 github
>>>>>>> 240e6bea71ab2f967f122476b7ee4edefbd5dd6b
