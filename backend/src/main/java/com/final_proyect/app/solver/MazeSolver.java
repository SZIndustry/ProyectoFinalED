package com.final_proyect.app.solver;

import com.final_proyect.app.models.Maze;
import com.final_proyect.app.models.Nodo;
import com.final_proyect.app.models.MazeResult;

import java.util.*;

public class MazeSolver {

    public static MazeResult resolverConBFS(Maze maze) {
        List<Nodo> nodos = maze.getNodos();
        int filas = maze.getFilas();
        int columnas = maze.getColumnas();

        Nodo inicio = null;
        Nodo fin = null;

        boolean[][] visitado = new boolean[filas][columnas];
        Map<Nodo, Nodo> padres = new HashMap<>();

        for (Nodo nodo : nodos) {
            if (nodo.isEsInicio()) inicio = nodo;
            if (nodo.isEsFin()) fin = nodo;
        }

        if (inicio == null || fin == null) {
            throw new IllegalArgumentException("Faltan nodos de inicio o fin");
        }

        Queue<Nodo> cola = new LinkedList<>();
        cola.add(inicio);
        visitado[inicio.getX()][inicio.getY()] = true;

        List<Map<String, Object>> resultado = new ArrayList<>();
        List<Map<String, Object>> camino = new ArrayList<>();

        int[][] direcciones = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!cola.isEmpty()) {
            Nodo actual = cola.poll();

            // Guardar nodo como visitado
            resultado.add(Map.of("x", actual.getX(), "y", actual.getY(), "tipo", "visitado"));

            if (actual.equals(fin)) break;

            for (int[] dir : direcciones) {
                int nx = actual.getX() + dir[0];
                int ny = actual.getY() + dir[1];

                if (nx < 0 || ny < 0 || nx >= filas || ny >= columnas) continue;

                Nodo vecino = encontrarNodo(nodos, nx, ny);
                if (vecino == null || vecino.isEsObstaculo() || visitado[nx][ny]) continue;

                visitado[nx][ny] = true;
                padres.put(vecino, actual);
                cola.add(vecino);
            }
        }

        // reconstruir camino
        Nodo actual = fin;
        while (padres.containsKey(actual)) {
            camino.add(Map.of("x", actual.getX(), "y", actual.getY(), "tipo", "camino"));
            actual = padres.get(actual);
        }
        camino.add(Map.of("x", inicio.getX(), "y", inicio.getY(), "tipo", "camino"));
        Collections.reverse(camino);

        // Agregar el camino al final
        resultado.addAll(camino);

        return new MazeResult(resultado, 0, maze.getAlgoritmo());
    }

    private static Nodo encontrarNodo(List<Nodo> nodos, int x, int y) {
        for (Nodo n : nodos) {
            if (n.getX() == x && n.getY() == y) return n;
        }
        return null;
    }
}
