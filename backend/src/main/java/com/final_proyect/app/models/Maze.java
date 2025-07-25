package com.final_proyect.app.models;

import java.util.List;

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
}
