package com.final_proyect.app.util;

import com.final_proyect.app.models.Maze;
import com.final_proyect.app.models.MazeResult;
import com.final_proyect.app.models.Nodo;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

public class CsvMazeLogger {

    // Eliminamos CSV_PATH fijo

    private static final String[] HEADERS = {
            "fecha", "algoritmo", "filas", "columnas", "tipoDato", "x", "y", "esInicio", "esFin", "esObstaculo", "tiempoEjecucion(ms)"
    };

    public static void guardarLaberintoConResultado(Maze maze, MazeResult resultado, long tiempoEjecucion) {
        System.out.println("[CSV] Iniciando guardado de laberinto y resultados...");

        File directorio = new File("logs");
        if (!directorio.exists()) {
            System.out.println("[CSV] Carpeta 'logs' no existe, creando...");
            boolean created = directorio.mkdirs();
            System.out.println("[CSV] Carpeta creada: " + created);
        } else {
            System.out.println("[CSV] Carpeta 'logs' ya existe.");
        }

        // Generar nombre de archivo único por cada llamada
        String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss_SSS"));
        String nombreArchivo = String.format("logs/laberinto_%s.csv", timestamp);

        System.out.println("[CSV] Archivo CSV: " + nombreArchivo);

        try (PrintWriter writer = new PrintWriter(new FileWriter(nombreArchivo, false))) {
            // Siempre escribimos encabezado porque es archivo nuevo
            writer.println(String.join(",", HEADERS));

            LocalDateTime ahora = LocalDateTime.now();

            // Guardar nodos originales
            System.out.println("[CSV] Guardando nodos originales: " + maze.getNodos().size());
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

            // Guardar nodos visitados y camino
            List<Map<String, Object>> listaResultados = resultado.getResultado();
            System.out.println("[CSV] Guardando resultados (visitados + camino): " + listaResultados.size());
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
                        ""
                );
            }

            // Guardar tiempo ejecución
            System.out.println("[CSV] Guardando tiempo de ejecución: " + tiempoEjecucion + "ms");
            writer.printf("%s,%s,%d,%d,%s,,,,,,, %d%n",
                    ahora,
                    maze.getAlgoritmo(),
                    maze.getFilas(),
                    maze.getColumnas(),
                    "tiempo",
                    tiempoEjecucion
            );

            System.out.println("[CSV] Guardado completado correctamente.");

        } catch (IOException e) {
            System.err.println("❌ Error al guardar laberinto CSV: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
