import 'package:flutter/material.dart';
import '../../data/models/maze_benchmark_result_model.dart';
import '../../data/models/nodo_model.dart';
import '../../data/services/benchmark_service.dart';

class BenchmarkController extends ChangeNotifier {
  final BenchmarkService _service = BenchmarkService();
  List<MazeBenchmarkResult> resultados = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> ejecutarBenchmark(List<List<Nodo>> maze) async {
    isLoading = true;
    notifyListeners();
    try {
      resultados = await _service.ejecutarBenchmark(maze);
    } catch (e) {
      errorMessage = e.toString();
      print(" Benchmark error: $errorMessage");
    }
    isLoading = false;
    notifyListeners();
  }
}