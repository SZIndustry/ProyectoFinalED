package com.final_proyect.app.models;

import java.util.List;
import java.util.Map;

public class MazeRequest {
    private int filas;
    private int columnas;
    private String algoritmo;
    private List<Map<String, Object>> nodos;

    public MazeRequest() {
    }

    public MazeRequest(int filas, int columnas, String algoritmo, List<Map<String, Object>> nodos) {
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

    public List<Map<String, Object>> getNodos() {
        return nodos;
    }

    public void setNodos(List<Map<String, Object>> nodos) {
        this.nodos = nodos;
    }
}
