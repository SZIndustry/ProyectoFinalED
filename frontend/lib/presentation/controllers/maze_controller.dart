// lib/presentation/controllers/maze_controller.dart
import 'package:frontend/logic/maze_generator.dart';

import '../../data/services/maze_service.dart';
import '../../data/models/maze_result_model.dart';

class MazeController {
  final MazeService _service = MazeService();
  late List<List<int>> _maze;
  bool _isSolving = false;
  MazeResult? _ultimoResultado;
  String? _errorMessage;
  
  final List<String> algoritmosDisponibles = ['bfs', 'dfs', 'a*'];
  String algoritmoSeleccionado = 'bfs';

  List<List<int>> generar(int filas, int columnas) {
    _maze = MazeGenerator.generarMaze(filas, columnas);
    _ultimoResultado = null;
    return _maze;
  }

  void toggleCell(int row, int col) {
    if (_maze[row][col] == 2 || _maze[row][col] == 3) return;
    _maze[row][col] = _maze[row][col] == 0 ? 1 : 0;
    _ultimoResultado = null;
  }

  List<List<int>> get maze => _maze;
  bool get isSolving => _isSolving;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;
  List<String> get algoritmos => algoritmosDisponibles;
  MazeResult? get ultimoResultado => _ultimoResultado;

  void cambiarAlgoritmo(String nuevoAlgoritmo) {
    if (algoritmosDisponibles.contains(nuevoAlgoritmo)) {
      algoritmoSeleccionado = nuevoAlgoritmo;
    }
  }

  Future<bool> verificarConexion() async {
    try {
      return await _service.verificarConexionBackend();
    } catch (e) {
      _errorMessage = "Error verificando conexión: ${e.toString()}";
      return false;
    }
  }

  Future<MazeResult?> resolver({
    required List<List<int>> maze,
    required int filas,
    required int columnas,
  }) async {
    _isSolving = true;
    _errorMessage = null;
    
    try {
      final conectado = await verificarConexion();
      if (!conectado) {
        throw Exception("No se pudo conectar al backend");
      }

      final resultado = await _service.enviarLaberinto(
        maze: maze,
        filas: filas,
        columnas: columnas,
        algoritmo: algoritmoSeleccionado,
      );
      
      _ultimoResultado = resultado;
      _isSolving = false;
      return resultado;
    } catch (e) {
      _isSolving = false;
      _errorMessage = e.toString();
      rethrow;
    }
  }

  void aplicarSolucion() {
    if (_ultimoResultado == null) return;

    // Primero resetear a estado inicial (excepto obstáculos, inicio y fin)
    for (int i = 0; i < _maze.length; i++) {
      for (int j = 0; j < _maze[i].length; j++) {
        if (_maze[i][j] != 1 && _maze[i][j] != 2 && _maze[i][j] != 3) {
          _maze[i][j] = 0; // Blanco (libre)
        }
      }
    }

    // Aplicar la solución recibida del backend
    for (final nodo in _ultimoResultado!.resultado) {
      final x = nodo['x'] as int;
      final y = nodo['y'] as int;
      final tipo = nodo['tipo'] as String;

      // Solo modificar si no es obstáculo, inicio o fin
      if (_maze[x][y] != 1 && _maze[x][y] != 2 && _maze[x][y] != 3) {
        _maze[x][y] = tipo == 'camino' ? 4 : 5;
      }
    }
  }
}