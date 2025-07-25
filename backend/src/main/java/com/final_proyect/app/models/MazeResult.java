package com.final_proyect.app.models;

import java.util.List;

public class MazeResult {
    private List<Nodo> camino;
    private long tiempoEjecucion; // en milisegundos
    private String algoritmoUsado;

    public MazeResult() {}

    public MazeResult(List<Nodo> camino, long tiempoEjecucion, String algoritmoUsado) {
        this.camino = camino;
        this.tiempoEjecucion = tiempoEjecucion;
        this.algoritmoUsado = algoritmoUsado;
    }

    public List<Nodo> getCamino() { return camino; }
    public void setCamino(List<Nodo> camino) { this.camino = camino; }

    public long getTiempoEjecucion() { return tiempoEjecucion; }
    public void setTiempoEjecucion(long tiempoEjecucion) { this.tiempoEjecucion = tiempoEjecucion; }

    public String getAlgoritmoUsado() { return algoritmoUsado; }
    public void setAlgoritmoUsado(String algoritmoUsado) { this.algoritmoUsado = algoritmoUsado; }
}
