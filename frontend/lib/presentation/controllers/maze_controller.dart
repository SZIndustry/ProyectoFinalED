import '../../data/models/nodo_model.dart';
import '../../data/models/maze_result_model.dart';
import '../../data/services/maze_service.dart';
import '../../logic/maze_generator.dart';

class MazeController {
  final MazeService _service = MazeService();
  List<List<Nodo>> maze = [];
  bool _isSolving = false;
  MazeResult? _lastResult;
  String? _errorMessage;

  final List<String> availableAlgorithms = ['bfs'];

  void generarLaberinto(int filas, int columnas) {
    maze = generarMaze(filas, columnas);
    maze[0][0].esInicio = true;
    maze[filas - 1][columnas - 1].esFin = true;
  }

  void toggleObstaculo(int x, int y) {
    final nodo = maze[x][y];
    if (!nodo.esInicio && !nodo.esFin) {
      nodo.esObstaculo = !nodo.esObstaculo;
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
    try {
      for (var paso in result.resultado) {
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
    } catch (e) {
      print("⚠️ Error aplicando resultado: $e");
    }
  }
}