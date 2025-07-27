class MazeGenerator {
  static List<List<int>> generarMaze(int filas, int columnas) {
    final maze = List.generate(filas, (i) => List.generate(columnas, (j) => 0));
    maze[0][0] = 2; // Inicio
    maze[filas - 1][columnas - 1] = 3; // Fin
    return maze;
  }
}