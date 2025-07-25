package com.final_proyect.app.models;

import java.util.Objects;

public class Nodo {
    private int x;
    private int y;
    private boolean esInicio;
    private boolean esFin;
    private boolean esObstaculo;

    public Nodo() {}

    public Nodo(int x, int y, boolean esInicio, boolean esFin, boolean esObstaculo) {
        this.x = x;
        this.y = y;
        this.esInicio = esInicio;
        this.esFin = esFin;
        this.esObstaculo = esObstaculo;
    }

    public int getX() { return x; }
    public void setX(int x) { this.x = x; }

    public int getY() { return y; }
    public void setY(int y) { this.y = y; }

    public boolean isEsInicio() { return esInicio; }
    public void setEsInicio(boolean esInicio) { this.esInicio = esInicio; }

    public boolean isEsFin() { return esFin; }
    public void setEsFin(boolean esFin) { this.esFin = esFin; }

    public boolean isEsObstaculo() { return esObstaculo; }
    public void setEsObstaculo(boolean esObstaculo) { this.esObstaculo = esObstaculo; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Nodo)) return false;
        Nodo nodo = (Nodo) o;
        return x == nodo.x && y == nodo.y;
    }

    @Override
    public int hashCode() {
        return Objects.hash(x, y);
    }

    @Override
    public String toString() {
        return "Nodo{" +
                "x=" + x +
                ", y=" + y +
                ", inicio=" + esInicio +
                ", fin=" + esFin +
                ", obstaculo=" + esObstaculo +
                '}';
    }
}
