package com.final_proyect.app.service;

import com.final_proyect.app.models.Maze;
import com.final_proyect.app.models.MazeResult;
import com.final_proyect.app.models.Nodo;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class MazeService {

    public MazeResult firstMethod(Maze maze) {
        long inicio = System.currentTimeMillis();

        // todo: algortmo
        List<Nodo> camino = new ArrayList<>();

        // Simulación de retorno
        for (Nodo nodo : maze.getNodos()) {
            if (nodo.isEsInicio()) {
                camino.add(nodo);
                break;
            }
        }

        long fin = System.currentTimeMillis();

        MazeResult resultado = new MazeResult();
        resultado.setCamino(camino);
        resultado.setTiempoEjecucion(fin - inicio);
        resultado.setAlgoritmoUsado(maze.getAlgoritmo());

        return resultado;
    }
}
