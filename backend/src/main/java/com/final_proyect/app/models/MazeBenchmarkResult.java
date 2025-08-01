package com.final_proyect.app.models;

import java.util.List;
import java.util.Map;

public class MazeBenchmarkResult {
    private String algoritmo;
    private long tiempoEjecucion;
    private int cantidadVisitados;
    private int longitudCamino;
    private List<Map<String, Object>> resultado; // Incluye visitados + camino

    public MazeBenchmarkResult() {}

    public MazeBenchmarkResult(String algoritmo, long tiempoEjecucion, int cantidadVisitados,
                               int longitudCamino, List<Map<String, Object>> resultado) {
        this.algoritmo = algoritmo;
        this.tiempoEjecucion = tiempoEjecucion;
        this.cantidadVisitados = cantidadVisitados;
        this.longitudCamino = longitudCamino;
        this.resultado = resultado;
    }

    public String getAlgoritmo() { return algoritmo; }
    public void setAlgoritmo(String algoritmo) { this.algoritmo = algoritmo; }

    public long getTiempoEjecucion() { return tiempoEjecucion; }
    public void setTiempoEjecucion(long tiempoEjecucion) { this.tiempoEjecucion = tiempoEjecucion; }

    public int getCantidadVisitados() { return cantidadVisitados; }
    public void setCantidadVisitados(int cantidadVisitados) { this.cantidadVisitados = cantidadVisitados; }

    public int getLongitudCamino() { return longitudCamino; }
    public void setLongitudCamino(int longitudCamino) { this.longitudCamino = longitudCamino; }

    public List<Map<String, Object>> getResultado() { return resultado; }
    public void setResultado(List<Map<String, Object>> resultado) { this.resultado = resultado; }
}
