import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/constants.dart'; // Aquí defines BASE_URL
import '../models/maze_result_model.dart'; // Resultado que regresa el backend
import '../models/nodo_model.dart';        // Modelo del nodo (celda) del laberinto

class MazeService {
  /// Envía el laberinto y el algoritmo seleccionado al backend.
  /// El backend debe procesar y devolver el resultado (camino, pasos, etc.).
  Future<MazeResult?> resolverMaze({
    required List<List<Nodo>> maze,
    required String algoritmo,
  }) async {
    final filas = maze.length;
    final columnas = maze[0].length;

    // Aplana la matriz de nodos a una lista para JSON
    final nodos = maze.expand((fila) => fila.map((n) => n.toJson())).toList();

    // Realiza la solicitud HTTP al backend
    final response = await http.post(
      Uri.parse('$BASE_URL/resolver'), // Ejemplo: http://localhost:8000/resolver
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'filas': filas,
        'columnas': columnas,
        'algoritmo': algoritmo, // Puede ser 'bfs', 'dfs', etc.
        'nodos': nodos,         // Lista de celdas en formato JSON
      }),
    );

    // Si la solicitud fue exitosa (código 200)
    if (response.statusCode == 200) {
      return MazeResult.fromJson(jsonDecode(response.body));
    } else {
      // Si hubo error, lanza excepción para manejarla en el controlador
      throw Exception('Error al resolver el laberinto: ${response.body}');
    }
  }
}
