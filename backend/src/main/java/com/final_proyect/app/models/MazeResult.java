package com.final_proyect.app.models;

import java.util.List;
import java.util.Map;

public class MazeResult {
    private List<Map<String, Object>> resultado;
    private long tiempoEjecucion;
    private String algoritmo;

    public MazeResult() {}

    public MazeResult(List<Map<String, Object>> resultado, long tiempoEjecucion, String algoritmo) {
        this.resultado = resultado;
        this.tiempoEjecucion = tiempoEjecucion;
        this.algoritmo = algoritmo;
    }

    public List<Map<String, Object>> getResultado() {
        return resultado;
    }

    public void setResultado(List<Map<String, Object>> resultado) {
        this.resultado = resultado;
    }

    public long getTiempoEjecucion() {
        return tiempoEjecucion;
    }

    public void setTiempoEjecucion(long tiempoEjecucion) {
        this.tiempoEjecucion = tiempoEjecucion;
    }

    public String getAlgoritmo() {
        return algoritmo;
    }

    public void setAlgoritmo(String algoritmo) {
        this.algoritmo = algoritmo;
    }
}
