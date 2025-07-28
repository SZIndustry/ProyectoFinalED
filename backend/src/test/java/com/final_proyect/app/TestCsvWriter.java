package com.final_proyect.app;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class TestCsvWriter {
    public static void main(String[] args) {
        testEscrituraArchivo();
    }

    public static void testEscrituraArchivo() {
        try {
            File dir = new File("logs");
            if (!dir.exists()) dir.mkdirs();
            FileWriter fw = new FileWriter("logs/test.csv");
            fw.write("prueba\n");
            fw.close();
            System.out.println("Archivo creado correctamente");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
