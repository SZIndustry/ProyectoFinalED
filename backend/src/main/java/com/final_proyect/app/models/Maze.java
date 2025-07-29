package com.final_proyect.app.models;

import java.util.List;

public class Maze {
    private int filas;
    private int columnas;
    private String algoritmo;
    private List<Nodo> nodos;

    public Maze() {}

    public Maze(int filas, int columnas, String algoritmo, List<Nodo> nodos) {
        this.filas = filas;
        this.columnas = columnas;
        this.algoritmo = algoritmo;
        this.nodos = nodos;
    }

    public int getFilas() {
        return filas;
    }

    public void setFilas(int filas) {
        this.filas = filas;
    }

    public int getColumnas() {
        return columnas;
    }

    public void setColumnas(int columnas) {
        this.columnas = columnas;
    }

    public String getAlgoritmo() {
        return algoritmo;
    }

    public void setAlgoritmo(String algoritmo) {
        this.algoritmo = algoritmo;
    }

    public List<Nodo> getNodos() {
        return nodos;
    }

    public void setNodos(List<Nodo> nodos) {
        this.nodos = nodos;
    }
}
