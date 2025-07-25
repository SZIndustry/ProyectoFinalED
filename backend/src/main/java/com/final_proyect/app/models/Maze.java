package com.final_proyect.app.models;

import java.util.List;
import java.util.Objects;

public class Maze {
    private int filas;
    private int columnas;
    private List<Nodo> nodos;
    private String algoritmo; // Ej: "bfs", "dfs", "a_star", etc.

    public Maze() {}

    public Maze(int filas, int columnas, List<Nodo> nodos, String algoritmo) {
        this.filas = filas;
        this.columnas = columnas;
        this.nodos = nodos;
        this.algoritmo = algoritmo;
    }

    public int getFilas() { return filas; }
    public void setFilas(int filas) { this.filas = filas; }

    public int getColumnas() { return columnas; }
    public void setColumnas(int columnas) { this.columnas = columnas; }

    public List<Nodo> getNodos() { return nodos; }
    public void setNodos(List<Nodo> nodos) { this.nodos = nodos; }

    public String getAlgoritmo() { return algoritmo; }
    public void setAlgoritmo(String algoritmo) { this.algoritmo = algoritmo; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Maze)) return false;
        Maze maze = (Maze) o;
        return filas == maze.filas &&
                columnas == maze.columnas &&
                Objects.equals(nodos, maze.nodos) &&
                Objects.equals(algoritmo, maze.algoritmo);
    }

    @Override
    public int hashCode() {
        return Objects.hash(filas, columnas, nodos, algoritmo);
    }

    @Override
    public String toString() {
        return "Maze{" +
                "filas=" + filas +
                ", columnas=" + columnas +
                ", algoritmo='" + algoritmo + '\'' +
                ", nodos=" + (nodos != null ? nodos.size() : 0) +
                '}';
    }
}
