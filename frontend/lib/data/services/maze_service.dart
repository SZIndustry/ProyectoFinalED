// lib/data/services/maze_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/models/nodo_model.dart';
import '../../data/models/maze_result_model.dart';

class MazeService {
  // CORRECCIÓN: Quitar '/resolver' del baseUrl
  final String baseUrl = "http://172.27.246.0:8081/api";
  bool _isBackendConnected = false;
  DateTime? _lastConnectionCheck;

  Future<bool> verificarConexionBackend() async {
    try {
      final response = await http.get(
        // CORRECCIÓN: Usar '/health' como endpoint completo
        Uri.parse('$baseUrl/health'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 3));

      _isBackendConnected = response.statusCode == 200;
      _lastConnectionCheck = DateTime.now();
      return _isBackendConnected;
    } catch (e) {
      _isBackendConnected = false;
      _lastConnectionCheck = DateTime.now();
      print("Error verificando conexión: $e");
      return false;
    }
  }

  bool get isBackendConnected {
    if (_lastConnectionCheck == null) return false;
    return _isBackendConnected && 
           DateTime.now().difference(_lastConnectionCheck!) < const Duration(minutes: 5);
  }

  Future<MazeResult?> enviarLaberinto({
    required List<List<int>> maze,
    required int filas,
    required int columnas,
    required String algoritmo,
  }) async {
    if (!isBackendConnected) {
      final conectado = await verificarConexionBackend();
      if (!conectado) throw Exception("Backend no disponible");
    }

    final nodos = <Map<String, dynamic>>[];

    for (int i = 0; i < filas; i++) {
      for (int j = 0; j < columnas; j++) {
        nodos.add(Nodo(
          x: i,
          y: j,
          esInicio: maze[i][j] == 2,
          esFin: maze[i][j] == 3,
          esObstaculo: maze[i][j] == 1,
        ).toJson());
      }
    }

    final payload = {
      'filas': filas,
      'columnas': columnas,
      'algoritmo': algoritmo,
      'nodos': nodos,
    };

    try {
      // CORRECCIÓN: Usar '/resolver' como endpoint completo
      final response = await http.post(
        Uri.parse('$baseUrl/resolver'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return MazeResult.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("Error de conexión: $e");
      throw Exception("Error al resolver el laberinto: $e");
    }
  }
}