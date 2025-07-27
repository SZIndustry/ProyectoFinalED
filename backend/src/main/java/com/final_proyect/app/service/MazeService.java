package com.final_proyect.app.service;

import com.final_proyect.app.models.Maze;
import com.final_proyect.app.models.MazeResult;
import com.final_proyect.app.solver.MazeSolver;
import org.springframework.stereotype.Service;

@Service
public class MazeService {

    public MazeResult resolver(Maze maze) {
        if (maze == null || maze.getNodos() == null || maze.getNodos().isEmpty()) {
            throw new IllegalArgumentException("El laberinto está vacío");
        }

        if (maze.getAlgoritmo() == null || maze.getAlgoritmo().isEmpty()) {
            throw new IllegalArgumentException("Debe especificar un algoritmo");
        }

        switch (maze.getAlgoritmo().toLowerCase()) {
            case "bfs": return MazeSolver.resolverConBFS(maze);
            case "dfs": return MazeSolver.resolverConDFS(maze);
            case "recursivo2": return MazeSolver.resolverRecursivo2Direcciones(maze);
            case "recursivo4": return MazeSolver.resolverRecursivo4Direcciones(maze);
            case "recursivobacktracking": return MazeSolver.resolverRecursivo4ConBacktracking(maze);
            default: throw new IllegalArgumentException("Algoritmo no soportado: " + maze.getAlgoritmo());
        }
    }
}
