package com.final_proyect.app.service;

import com.final_proyect.app.models.Maze;
import com.final_proyect.app.models.MazeResult;
import com.final_proyect.app.models.MazeBenchmarkResult;
import com.final_proyect.app.models.Nodo;
import com.final_proyect.app.solver.MazeSolver;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class BenchmarkService {

    public List<MazeBenchmarkResult> benchmark(Maze mazeOriginal) {
        List<MazeBenchmarkResult> resultados = new ArrayList<>();

        String[] algoritmos = {
                "bfs", "dfs", "recursivo2", "recursivo4", "recursivobacktracking"
        };

        for (String algoritmo : algoritmos) {
            // Copia del maze
            Maze maze = new Maze(
                    mazeOriginal.getFilas(),
                    mazeOriginal.getColumnas(),
                    algoritmo,
                    copiarNodos(mazeOriginal.getNodos())
            );

            long inicio = System.nanoTime();
            MazeResult resultado = null;

            try {
                switch (algoritmo) {
                    case "bfs": resultado = MazeSolver.resolverConBFS(maze); break;
                    case "dfs": resultado = MazeSolver.resolverConDFS(maze); break;
                    case "recursivo2": resultado = MazeSolver.resolverRecursivo2Direcciones(maze); break;
                    case "recursivo4": resultado = MazeSolver.resolverRecursivo4Direcciones(maze); break;
                    case "recursivobacktracking": resultado = MazeSolver.resolverRecursivo4ConBacktracking(maze); break;
                    default: throw new IllegalArgumentException("Algoritmo no válido: " + algoritmo);
                }
            } catch (Exception e) {
                System.out.println("⚠️ Error en " + algoritmo + ": " + e.getMessage());
                continue;
            }

            long fin = System.nanoTime();

            List<Map<String, Object>> lista = resultado.getResultado();
            int visitados = (int) lista.stream().filter(n -> "visitado".equals(n.get("tipo"))).count();
            int camino = (int) lista.stream().filter(n -> "camino".equals(n.get("tipo"))).count();

            MazeBenchmarkResult resumen = new MazeBenchmarkResult(
                    algoritmo,
                    (fin - inicio) / 1_000_000,
                    visitados,
                    camino,
                    lista
            );

            resultados.add(resumen);
        }

        return resultados;
    }

    private List<Nodo> copiarNodos(List<Nodo> originales) {
        List<Nodo> copia = new ArrayList<>();
        for (Nodo n : originales) {
            copia.add(new Nodo(n.getX(), n.getY(), n.isEsInicio(), n.isEsFin(), n.isEsObstaculo()));
        }
        return copia;
    }
}
