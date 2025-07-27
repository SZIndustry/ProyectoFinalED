import '../data/models/nodo_model.dart';

List<List<Nodo>> generarMaze(int filas, int columnas) {
  return List.generate(filas, (x) {
    return List.generate(columnas, (y) {
      return Nodo(x: x, y: y);
    });
  });
}