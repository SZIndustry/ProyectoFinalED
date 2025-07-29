import 'package:flutter/material.dart';
import '../../data/models/maze_benchmark_result_model.dart';

class BenchmarkCard extends StatelessWidget {
  final MazeBenchmarkResult result;

  const BenchmarkCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(result.algoritmo.toUpperCase(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("⏱ Tiempo: ${result.tiempoEjecucion} ms"),
            Text("👣 Visitados: ${result.cantidadVisitados}"),
            Text("🚩 Longitud del camino: ${result.longitudCamino}"),
          ],
        ),
      ),
    );
  }
}