
import 'package:flutter/material.dart';
import '../../data/models/nodo_model.dart';
import '../../data/models/maze_result_model.dart';
import '../../data/services/maze_service.dart';
import '../../logic/maze_generator.dart';

class MazeController extends ChangeNotifier {
  final MazeService _service = MazeService();
  List<List<Nodo>> maze = [];
  bool _isSolving = false;
  MazeResult? _lastResult;
  String? _errorMessage;

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

      final result = await _service.resolverMaze(
        maze: maze,
        algoritmo: algoritmo,
      );

      if (result != null) {
        _lastResult = result;
        aplicarResultado(result);
      }
    } catch (e, stack) {
      _errorMessage = e.toString();
      print("❌ Error en MazeController.resolver(): $_errorMessage");
      print(stack);
    }

    _isSolving = false;
  }

  void aplicarResultado(MazeResult result) {
    print("Aplicando resultado: ${result.resultado.length} pasos en laberinto de ${maze.length}x${maze[0].length}");
    int contador = 0;
    try {
      for (var paso in result.resultado) {
        int x = paso['x'];
        int y = paso['y'];
        String tipo = paso['tipo'];
        if (x >= 0 && y >= 0 && x < maze.length && y < maze[0].length) {
          final nodo = maze[x][y];
          if (!nodo.esInicio && !nodo.esFin && !nodo.esObstaculo) {
            nodo.tipo = tipo;
            if (contador < 10) {
              print("Paso $contador: nodo [$x,$y] tipo=$tipo");
            }
            contador++;
          }
        }
      }
      notifyListeners();
    } catch (e) {
      print("⚠️ Error aplicando resultado: $e");
    }
  }

  void seleccionarInicioFin(int x, int y) {
    final nodo = maze[x][y];

    // Si ya hay uno marcado como inicio y este nodo no lo es, ponemos fin
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

}