package com.final_proyect.app.controller;

import com.final_proyect.app.models.Maze;
import com.final_proyect.app.models.MazeRequest;
import com.final_proyect.app.models.MazeResult;
import com.final_proyect.app.models.Nodo;
import com.final_proyect.app.service.MazeService;
import com.final_proyect.app.util.CsvMazeLogger;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.*;

@RestController
@RequestMapping("/api")
public class MazeController {

    private final MazeService mazeService;

    public MazeController(MazeService mazeService) {
        this.mazeService = mazeService;
    }

    @GetMapping("/health")
    public ResponseEntity<String> healthCheck() {
        return ResponseEntity.ok("Backend conectado");
    }

    @PostMapping("/resolver")
    public ResponseEntity<MazeResult> resolverLaberinto(@RequestBody MazeRequest request) {
        System.out.println("✅ Petición recibida en /resolver:");
        System.out.println("Filas: " + request.getFilas());
        System.out.println("Columnas: " + request.getColumnas());
        System.out.println("Algoritmo: " + request.getAlgoritmo());
        System.out.println("Nodos recibidos: ");
        for (Map<String, Object> nodoMap : request.getNodos()) {
            System.out.println(nodoMap);
        }

        long startTime = System.currentTimeMillis();

        List<Nodo> nodos = new ArrayList<>();
        for (Map<String, Object> nodoMap : request.getNodos()) {
            int x = ((Number) nodoMap.get("x")).intValue();
            int y = ((Number) nodoMap.get("y")).intValue();

            boolean esInicio = Boolean.TRUE.equals(nodoMap.get("esInicio"));
            boolean esFin = Boolean.TRUE.equals(nodoMap.get("esFin"));
            boolean esObstaculo = Boolean.TRUE.equals(nodoMap.get("esObstaculo"));

            nodos.add(new Nodo(x, y, esInicio, esFin, esObstaculo));
        }

        Maze maze = new Maze(
                request.getFilas(),
                request.getColumnas(),
                request.getAlgoritmo(),
                nodos
        );

        MazeResult result = mazeService.resolver(maze);

        long tiempoEjecucion = System.currentTimeMillis() - startTime;

        // ✅ Guardar todo en CSV: laberinto + resultado + tiempo ejecución
        CsvMazeLogger.guardarLaberintoConResultado(maze, result, tiempoEjecucion);

        System.out.println("\n🚀 ENVIANDO RESPUESTA AL FRONTEND:");
        System.out.println("• Algoritmo: " + result.getAlgoritmo());
        System.out.println("• Tiempo ejecución: " + tiempoEjecucion + "ms");
        System.out.println("• Nodos solución: " + result.getResultado().size());

        return ResponseEntity.ok(new MazeResult(
                result.getResultado(),
                tiempoEjecucion,
                result.getAlgoritmo()
        ));
    }
}
