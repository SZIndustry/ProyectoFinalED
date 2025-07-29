import 'package:flutter/material.dart';
import '../../data/models/nodo_model.dart';
import '../../data/models/maze_result_model.dart';
import '../../data/services/maze_service.dart';
import '../../logic/maze_generator.dart';

class MazeController extends ChangeNotifier {
  final MazeService _service = MazeService();
  List<List<Nodo>> maze = [];
  MazeResult? _lastResult;
  String? _errorMessage;
  bool _isSolving = false;

  int _pasoActual = 0;
  List<Map<String, dynamic>> _pasos = [];

  final List<String> availableAlgorithms = [
    'recursivo2',
    'recursivo4',
    'recursivobacktracking',
    'bfs',
    'dfs',
  ];

  void generarLaberinto(int filas, int columnas) {
    maze = generarMaze(filas, columnas);
    maze[0][0].esInicio = true;
    maze[filas - 1][columnas - 1].esFin = true;
    notifyListeners();
  }

  void toggleObstaculo(int x, int y) {
    final nodo = maze[x][y];
    if (!nodo.esInicio && !nodo.esFin) {
      nodo.esObstaculo = !nodo.esObstaculo;
      notifyListeners();
    }
  }

  void seleccionarInicioFin(int x, int y) {
    final nodo = maze[x][y];
    final inicio = maze.expand((e) => e).firstWhere((n) => n.esInicio, orElse: () => Nodo(x: -1, y: -1));
    final fin = maze.expand((e) => e).firstWhere((n) => n.esFin, orElse: () => Nodo(x: -1, y: -1));

    if (!nodo.esInicio && !nodo.esFin && !nodo.esObstaculo) {
      if (inicio.x == -1) {
        nodo.esInicio = true;
      } else if (fin.x == -1) {
        nodo.esFin = true;
      } else {
        inicio.esInicio = false;
        nodo.esInicio = true;
        fin.esFin = false;
      }
      notifyListeners();
    }
  }

  Future<void> resolver(String algoritmo) async {
    if (_isSolving) return;
    _isSolving = true;

    try {
      for (var fila in maze) {
        for (var nodo in fila) {
          nodo.resetTipo();
        }
      }
      notifyListeners();

      final result = await _service.resolverMaze(maze: maze, algoritmo: algoritmo);
      if (result != null) {
        _lastResult = result;
        _pasos = result.resultado;
        _pasoActual = 0;
        aplicarResultadoCompleto(); // mostrar todo inicialmente
      }
    } catch (e, stack) {
      _errorMessage = e.toString();
      print("Error en resolver: $_errorMessage");
      print(stack);
    }

    _isSolving = false;
  }

  void inicializarPasoAPaso() {
    if (_lastResult != null) {
      _pasos = _lastResult!.resultado;
      _pasoActual = 0;
      for (var fila in maze) {
        for (var nodo in fila) {
          nodo.resetTipo();
        }
      }
      notifyListeners();
    }
  }

  void aplicarResultadoPasoActual() {
    for (var fila in maze) {
      for (var nodo in fila) {
        nodo.resetTipo();
      }
    }

    for (int i = 0; i <= _pasoActual && i < _pasos.length; i++) {
      final paso = _pasos[i];
      int x = paso['x'];
      int y = paso['y'];
      String tipo = paso['tipo'];

      if (x >= 0 && y >= 0 && x < maze.length && y < maze[0].length) {
        final nodo = maze[x][y];
        if (!nodo.esInicio && !nodo.esFin && !nodo.esObstaculo) {
          nodo.tipo = tipo;
        }
      }
    }
    notifyListeners();
  }

  void avanzarPaso() {
    if (_pasoActual < _pasos.length - 1) {
      _pasoActual++;
      aplicarResultadoPasoActual();
    }
  }

  void retrocederPaso() {
    if (_pasoActual > 0) {
      _pasoActual--;
      aplicarResultadoPasoActual();
    }
  }

  void aplicarResultadoCompleto() {
    if (_lastResult == null) return;

    for (var fila in maze) {
      for (var nodo in fila) {
        nodo.resetTipo();
      }
    }

    for (var paso in _lastResult!.resultado) {
      int x = paso['x'];
      int y = paso['y'];
      String tipo = paso['tipo'];

      if (x >= 0 && y >= 0 && x < maze.length && y < maze[0].length) {
        final nodo = maze[x][y];
        if (!nodo.esInicio && !nodo.esFin && !nodo.esObstaculo) {
          nodo.tipo = tipo;
        }
      }
    }
    notifyListeners();
  }
}