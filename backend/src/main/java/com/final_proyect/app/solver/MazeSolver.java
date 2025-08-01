package com.final_proyect.app.solver;

import com.final_proyect.app.models.Maze;
import com.final_proyect.app.models.Nodo;
import com.final_proyect.app.models.MazeResult;

import java.util.*;

public class MazeSolver {

    // === BFS ===
    public static MazeResult resolverConBFS(Maze maze) {
        return bfs(maze);
    }

    // === DFS ===
    public static MazeResult resolverConDFS(Maze maze) {
        return dfs(maze);
    }

    // === Recursivo 2 direcciones (sin backtracking) ===
    public static MazeResult resolverRecursivo2Direcciones(Maze maze) {
        return recursivoDirecciones(maze, new int[][]{{0, 1}, {1, 0}});
    }

    // === Recursivo 4 direcciones (sin backtracking) ===
    public static MazeResult resolverRecursivo4Direcciones(Maze maze) {
        return recursivoDirecciones(maze, new int[][]{{0, 1}, {1, 0}, {0, -1}, {-1, 0}});
    }

    // === Recursivo 4 direcciones con backtracking ===
    public static MazeResult resolverRecursivo4ConBacktracking(Maze maze) {
        return recursivoDireccionesConBacktracking(maze, new int[][]{{-1, 0}, {1, 0}, {0, -1}, {0, 1}});
    }

    // === Implementación BFS ===
    private static MazeResult bfs(Maze maze) {
        List<Nodo> nodos = maze.getNodos();
        int filas = maze.getFilas();
        int columnas = maze.getColumnas();

        Nodo inicio = null, fin = null;
        for (Nodo nodo : nodos) {
            if (nodo.isEsInicio()) inicio = nodo;
            if (nodo.isEsFin()) fin = nodo;
        }

        boolean[][] visitado = new boolean[filas][columnas];
        Map<Nodo, Nodo> padres = new HashMap<>();
        Queue<Nodo> cola = new LinkedList<>();
        List<Map<String, Object>> resultado = new ArrayList<>();
        List<Map<String, Object>> camino = new ArrayList<>();

        cola.add(inicio);
        visitado[inicio.getX()][inicio.getY()] = true;
        int[][] direcciones = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!cola.isEmpty()) {
            Nodo actual = cola.poll();
            resultado.add(Map.of("x", actual.getX(), "y", actual.getY(), "tipo", "visitado"));

            if (actual.equals(fin)) break;

            for (int[] dir : direcciones) {
                int nx = actual.getX() + dir[0];
                int ny = actual.getY() + dir[1];
                if (!esValido(nodos, nx, ny, filas, columnas, visitado)) continue;

                Nodo vecino = encontrarNodo(nodos, nx, ny);
                visitado[nx][ny] = true;
                padres.put(vecino, actual);
                cola.add(vecino);
            }
        }

        Nodo actual = fin;
        while (padres.containsKey(actual)) {
            camino.add(Map.of("x", actual.getX(), "y", actual.getY(), "tipo", "camino"));
            actual = padres.get(actual);
        }
        camino.add(Map.of("x", inicio.getX(), "y", inicio.getY(), "tipo", "camino"));
        Collections.reverse(camino);
        resultado.addAll(camino);

        return new MazeResult(resultado, 0, maze.getAlgoritmo());
    }

    // === Implementación DFS ===
    private static MazeResult dfs(Maze maze) {
        List<Nodo> nodos = maze.getNodos();
        int filas = maze.getFilas();
        int columnas = maze.getColumnas();
        boolean[][] visitado = new boolean[filas][columnas];
        List<Map<String, Object>> resultado = new ArrayList<>();
        List<Map<String, Object>> camino = new ArrayList<>();

        Nodo inicio = nodos.stream().filter(Nodo::isEsInicio).findFirst().orElse(null);
        Nodo fin = nodos.stream().filter(Nodo::isEsFin).findFirst().orElse(null);

        Map<Nodo, Nodo> padres = new HashMap<>();
        dfsRec(inicio, fin, nodos, visitado, resultado, padres, filas, columnas);

        Nodo actual = fin;
        while (padres.containsKey(actual)) {
            camino.add(Map.of("x", actual.getX(), "y", actual.getY(), "tipo", "camino"));
            actual = padres.get(actual);
        }
        camino.add(Map.of("x", inicio.getX(), "y", inicio.getY(), "tipo", "camino"));
        Collections.reverse(camino);
        resultado.addAll(camino);

        return new MazeResult(resultado, 0, maze.getAlgoritmo());
    }

    private static boolean dfsRec(Nodo actual, Nodo fin, List<Nodo> nodos, boolean[][] visitado,
                                  List<Map<String, Object>> resultado, Map<Nodo, Nodo> padres,
                                  int filas, int columnas) {
        if (actual == null || actual.isEsObstaculo()) return false;
        if (visitado[actual.getX()][actual.getY()]) return false;

        visitado[actual.getX()][actual.getY()] = true;
        resultado.add(Map.of("x", actual.getX(), "y", actual.getY(), "tipo", "visitado"));

        if (actual.equals(fin)) return true;

        int[][] direcciones = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        for (int[] dir : direcciones) {
            int nx = actual.getX() + dir[0];
            int ny = actual.getY() + dir[1];
            if (!esValido(nodos, nx, ny, filas, columnas, visitado)) continue;

            Nodo vecino = encontrarNodo(nodos, nx, ny);
            padres.put(vecino, actual);
            if (dfsRec(vecino, fin, nodos, visitado, resultado, padres, filas, columnas)) return true;
        }

        return false;
    }

    // === Método Recursivo sin Backtracking ===
    private static MazeResult recursivoDirecciones(Maze maze, int[][] direcciones) {
        List<Nodo> nodos = maze.getNodos();
        int filas = maze.getFilas();
        int columnas = maze.getColumnas();
        Nodo inicio = nodos.stream().filter(Nodo::isEsInicio).findFirst().orElse(null);
        Nodo fin = nodos.stream().filter(Nodo::isEsFin).findFirst().orElse(null);

        boolean[][] visitado = new boolean[filas][columnas];
        List<Map<String, Object>> resultado = new ArrayList<>();
        List<Nodo> path = new ArrayList<>();

        resolverRec(inicio, fin, nodos, visitado, direcciones, resultado, path);

        for (Nodo n : path) {
            resultado.add(Map.of("x", n.getX(), "y", n.getY(), "tipo", "camino"));
        }

        return new MazeResult(resultado, 0, maze.getAlgoritmo());
    }

    // === Recursivo SIN backtracking ===
    private static boolean resolverRec(Nodo actual, Nodo fin, List<Nodo> nodos, boolean[][] visitado,
                                       int[][] direcciones, List<Map<String, Object>> resultado, List<Nodo> path) {
        if (actual == null || actual.isEsObstaculo()) return false;
        int x = actual.getX(), y = actual.getY();
        if (visitado[x][y]) return false;

        visitado[x][y] = true;
        resultado.add(Map.of("x", x, "y", y, "tipo", "visitado"));
        path.add(actual);

        if (actual.equals(fin)) return true;

        for (int[] dir : direcciones) {
            int nx = x + dir[0];
            int ny = y + dir[1];
            if (!esValido(nodos, nx, ny, visitado.length, visitado[0].length, visitado)) continue;

            Nodo vecino = encontrarNodo(nodos, nx, ny);
            if (resolverRec(vecino, fin, nodos, visitado, direcciones, resultado, path)) return true;
        }

        // No hay backtracking: no se remueve el nodo del path
        return false;
    }

    // === Método Recursivo CON Backtracking ===
    private static MazeResult recursivoDireccionesConBacktracking(Maze maze, int[][] direcciones) {
        List<Nodo> nodos = maze.getNodos();
        int filas = maze.getFilas();
        int columnas = maze.getColumnas();
        Nodo inicio = nodos.stream().filter(Nodo::isEsInicio).findFirst().orElse(null);
        Nodo fin = nodos.stream().filter(Nodo::isEsFin).findFirst().orElse(null);

        boolean[][] visitado = new boolean[filas][columnas];
        List<Map<String, Object>> resultado = new ArrayList<>();
        List<Nodo> path = new ArrayList<>();

        resolverRecConBacktracking(inicio, fin, nodos, visitado, direcciones, resultado, path);

        for (Nodo n : path) {
            resultado.add(Map.of("x", n.getX(), "y", n.getY(), "tipo", "camino"));
        }

        return new MazeResult(resultado, 0, maze.getAlgoritmo());
    }

    private static boolean resolverRecConBacktracking(Nodo actual, Nodo fin, List<Nodo> nodos, boolean[][] visitado,
                                                      int[][] direcciones, List<Map<String, Object>> resultado, List<Nodo> path) {
        if (actual == null || actual.isEsObstaculo()) return false;
        int x = actual.getX(), y = actual.getY();
        if (visitado[x][y]) return false;

        visitado[x][y] = true;
        resultado.add(Map.of("x", x, "y", y, "tipo", "visitado"));
        path.add(actual);

        if (actual.equals(fin)) return true;

        for (int[] dir : direcciones) {
            int nx = x + dir[0];
            int ny = y + dir[1];
            if (!esValido(nodos, nx, ny, visitado.length, visitado[0].length, visitado)) continue;

            Nodo vecino = encontrarNodo(nodos, nx, ny);
            if (resolverRecConBacktracking(vecino, fin, nodos, visitado, direcciones, resultado, path)) return true;
        }

        // Aquí sí se hace backtracking
        path.remove(path.size() - 1);
        return false;
    }

    // === Utilitarios ===
    private static Nodo encontrarNodo(List<Nodo> nodos, int x, int y) {
        for (Nodo n : nodos) {
            if (n.getX() == x && n.getY() == y) return n;
        }
        return null;
    }

    private static boolean esValido(List<Nodo> nodos, int x, int y, int filas, int columnas, boolean[][] visitado) {
        if (x < 0 || y < 0 || x >= filas || y >= columnas) return false;
        Nodo nodo = encontrarNodo(nodos, x, y);
        return nodo != null && !nodo.isEsObstaculo() && !visitado[x][y];
    }
}
