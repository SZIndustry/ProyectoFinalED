import '../data/models/nodo_model.dart';

class MazeGeneratorBenchmark {
  final int filas;
  final int columnas;

  MazeGeneratorBenchmark({required this.filas, required this.columnas});

  List<List<Nodo>> generarMaze() {
    return List.generate(filas, (x) {
      return List.generate(columnas, (y) {
        return Nodo(x: x, y: y);
      });
    });
  }
}
