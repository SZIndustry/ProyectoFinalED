package com.final_proyect.app.service;

import com.final_proyect.app.models.Maze;
import com.final_proyect.app.models.MazeResult;
import com.final_proyect.app.models.Nodo;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class MazeService {

    public MazeResult firstMethod(Maze maze) {
        long inicio = System.currentTimeMillis();

        List<Nodo> camino = bfs(maze);

        long fin = System.currentTimeMillis();

        MazeResult resultado = new MazeResult();
        resultado.setCamino(camino);
        resultado.setTiempoEjecucion(fin - inicio);
        resultado.setAlgoritmoUsado(maze.getAlgoritmo());

        return resultado;
    }

    private List<Nodo> bfs(Maze maze) {
        Nodo[][] grid = construirGrid(maze); // Convierte lista de nodos a matriz
        Nodo inicio = null;
        Nodo fin = null;

        for (Nodo[] fila : grid) {
            for (Nodo nodo : fila) {
                if (nodo.isEsInicio()) {
                    inicio = nodo;
                } else if (nodo.isEsFinal()) {
                    fin = nodo;
                }
            }
        }

        if (inicio == null || fin == null) {
            return Collections.emptyList();
        }

        Queue<Nodo> queue = new LinkedList<>();
        Map<Nodo, Nodo> padres = new HashMap<>();
        Set<Nodo> visitados = new HashSet<>();

        queue.add(inicio);
        visitados.add(inicio);

        while (!queue.isEmpty()) {
            Nodo actual = queue.poll();

            if (actual.equals(fin)) {
                return reconstruirCamino(padres, fin);
            }

            for (Nodo vecino : obtenerVecinos(actual, grid)) {
                if (!visitados.contains(vecino) && !vecino.isEsMuro()) {
                    queue.add(vecino);
                    visitados.add(vecino);
                    padres.put(vecino, actual);
                }
            }
        }

        return Collections.emptyList(); // No se encontró camino
    }

    private List<Nodo> reconstruirCamino(Map<Nodo, Nodo> padres, Nodo fin) {
        List<Nodo> camino = new ArrayList<>();
        Nodo actual = fin;
        while (actual != null) {
            camino.add(actual);
            actual = padres.get(actual);
        }
        Collections.reverse(camino);
        return camino;
    }

    private List<Nodo> obtenerVecinos(Nodo nodo, Nodo[][] grid) {
        List<Nodo> vecinos = new ArrayList<>();
        int x = nodo.getX();
        int y = nodo.getY();

        if (x > 0) vecinos.add(grid[y][x - 1]); // izquierda
        if (x < grid[0].length - 1) vecinos.add(grid[y][x + 1]); // derecha
        if (y > 0) vecinos.add(grid[y - 1][x]); // arriba
        if (y < grid.length - 1) vecinos.add(grid[y + 1][x]); // abajo

        return vecinos;
    }

    private Nodo[][] construirGrid(Maze maze) {
        int width = maze.getAncho();
        int height = maze.getAlto();
        Nodo[][] grid = new Nodo[height][width];

        for (Nodo nodo : maze.getNodos()) {
            grid[nodo.getY()][nodo.getX()] = nodo;
        }

        return grid;
    }
}
