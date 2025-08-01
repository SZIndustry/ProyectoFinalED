package com.final_proyect.app.controller;

import com.final_proyect.app.models.Maze;
import com.final_proyect.app.models.MazeBenchmarkResult;
import com.final_proyect.app.service.BenchmarkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/benchmark")
public class BenchmarkController {

    @Autowired
    private BenchmarkService benchmarkService;

    @PostMapping
    public ResponseEntity<List<MazeBenchmarkResult>> ejecutarBenchmark(@RequestBody Maze maze) {
        List<MazeBenchmarkResult> resultados = benchmarkService.benchmark(maze);
        return ResponseEntity.ok(resultados);
    }
}
