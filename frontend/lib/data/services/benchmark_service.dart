import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants.dart';
import '../models/maze_benchmark_result_model.dart';
import '../models/nodo_model.dart';

class BenchmarkService {
  Future<List<MazeBenchmarkResult>> ejecutarBenchmark(List<List<Nodo>> maze) async {
    final filas = maze.length;
    final columnas = maze[0].length;
    final nodos = maze.expand((fila) => fila.map((n) => n.toJson())).toList();

    final response = await http.post(
      Uri.parse('$BASE_URL/benchmark'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'filas': filas,
        'columnas': columnas,
        'nodos': nodos,
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => MazeBenchmarkResult.fromJson(e)).toList();
    } else {
      throw Exception('Error en benchmark: ${response.body}');
    }
  }
}