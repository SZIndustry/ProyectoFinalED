package com.final_proyect.app.util;

import com.final_proyect.app.models.Maze;
import com.final_proyect.app.models.MazeResult;
import com.final_proyect.app.models.Nodo;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

public class CsvMazeLogger {

    private static final String CSV_PATH = "logs/laberintos_recibidos.csv";
    private static final String[] HEADERS = {
            "fecha", "algoritmo", "filas", "columnas", "tipoDato", "x", "y", "esInicio", "esFin", "esObstaculo", "tiempoEjecucion(ms)"
    };

    public static void guardarLaberintoConResultado(Maze maze, MazeResult resultado, long tiempoEjecucion) {

        File directorio = new File("logs");
        if (!directorio.exists()) {
            directorio.mkdirs(); // crea la carpeta logs si no existe
        }

        boolean escribirEncabezado = !new File(CSV_PATH).exists();

        try (PrintWriter writer = new PrintWriter(new FileWriter(CSV_PATH, true))) {
            if (escribirEncabezado) {
                writer.println(String.join(",", HEADERS));
            }

            LocalDateTime ahora = LocalDateTime.now();

            // Guardar nodos originales
            for (Nodo nodo : maze.getNodos()) {
                writer.printf("%s,%s,%d,%d,%s,%d,%d,%b,%b,%b,%s%n",
                        ahora,
                        maze.getAlgoritmo(),
                        maze.getFilas(),
                        maze.getColumnas(),
                        "nodo",
                        nodo.getX(),
                        nodo.getY(),
                        nodo.isEsInicio(),
                        nodo.isEsFin(),
                        nodo.isEsObstaculo(),
                        ""
                );
            }

            // Guardar nodos visitados y camino según MazeResult (resultado.getResultado())
            List<Map<String, Object>> listaResultados = resultado.getResultado();
            for (Map<String, Object> entry : listaResultados) {
                String tipo = (String) entry.get("tipo"); // "visitado" o "camino"
                int x = (int) entry.get("x");
                int y = (int) entry.get("y");

                writer.printf("%s,%s,%d,%d,%s,%d,%d,,,,%s%n",
                        ahora,
                        maze.getAlgoritmo(),
                        maze.getFilas(),
                        maze.getColumnas(),
                        tipo,
                        x,
                        y,
                        "" // tiempo vacío aquí
                );
            }

            // Guardar tiempo de ejecución en una fila aparte
            writer.printf("%s,%s,%d,%d,%s,,,,,,, %d%n",
                    ahora,
                    maze.getAlgoritmo(),
                    maze.getFilas(),
                    maze.getColumnas(),
                    "tiempo",
                    tiempoEjecucion
            );

        } catch (IOException e) {
            System.err.println("❌ Error al guardar laberinto CSV: " + e.getMessage());
        }
    }
}
