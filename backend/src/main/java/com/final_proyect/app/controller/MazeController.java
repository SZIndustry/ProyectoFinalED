package com.final_proyect.app.controller;

import com.final_proyect.app.models.Maze;
import com.final_proyect.app.models.MazeResult;
import com.final_proyect.app.service.MazeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "*")  // Permitir solicitudes del frontend (Flutter Web)
@RestController
@RequestMapping("/maze")     // Ruta base: /maze
public class MazeController {

    @Autowired
    private MazeService mazeService;

    @PostMapping("/resolver")
    public MazeResult resolverLaberinto(@RequestBody Maze maze) {
        return mazeService.firstMethod(maze);
    }

    @GetMapping("/")
    public String prueba() {
        return "Controlador de laberintos funcionando correctamente.";
    }
}
