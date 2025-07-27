import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants.dart';
import '../models/maze_result_model.dart';
import '../models/nodo_model.dart';

class MazeService {
  Future<MazeResult?> resolverMaze({
    required List<List<Nodo>> maze,
    required String algoritmo,
  }) async {
    final filas = maze.length;
    final columnas = maze[0].length;

    final nodos = maze.expand((fila) => fila.map((n) => n.toJson())).toList();

    final response = await http.post(
      Uri.parse('$BASE_URL/resolver'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'filas': filas,
        'columnas': columnas,
        'algoritmo': algoritmo,
        'nodos': nodos,
      }),
    );

    if (response.statusCode == 200) {
      return MazeResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al resolver el laberinto');
    }
  }
}