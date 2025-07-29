package com.final_proyect.app.controller;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.*;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/logs")
public class LogsController {

    private final Path logsDir = Paths.get("logs");

    @GetMapping("/list")
    public ResponseEntity<List<String>> listarArchivos() throws IOException {
        if (!Files.exists(logsDir)) {
            return ResponseEntity.ok(List.of());
        }
        List<String> archivos = Files.list(logsDir)
                .filter(f -> f.toString().endsWith(".csv"))
                .map(f -> f.getFileName().toString())
                .collect(Collectors.toList());
        return ResponseEntity.ok(archivos);
    }

    @GetMapping("/file/{filename:.+}")
    public ResponseEntity<Resource> descargarArchivo(@PathVariable String filename) {
        try {
            Path file = logsDir.resolve(filename).normalize();
            if (!Files.exists(file) || !file.toString().endsWith(".csv")) {
                return ResponseEntity.notFound().build();
            }

            Resource resource = new UrlResource(file.toUri());
            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType("text/csv"))
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + file.getFileName().toString() + "\"")
                    .body(resource);
        } catch (MalformedURLException e) {
            return ResponseEntity.badRequest().build();
        }
    }
}
