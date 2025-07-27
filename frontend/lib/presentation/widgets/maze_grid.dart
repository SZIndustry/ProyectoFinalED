import 'package:flutter/material.dart';

class MazeGrid extends StatelessWidget {
  final List<List<int>> maze;
  final void Function(int, int) onCellTap;
  final bool isSolving;

  const MazeGrid({
    super.key,
    required this.maze,
    required this.onCellTap,
    this.isSolving = false,
  });

  Color _getColor(int value) {
    switch (value) {
      case 0:  // Casilla libre
        return Colors.white;
      case 1:  // Obstáculo
        return Colors.black;
      case 2:  // Inicio
        return Colors.green;
      case 3:  // Fin
        return Colors.red;
      case 4:  // Camino solución
        return Colors.blue;
      case 5:  // Nodos visitados (opcional)
        return Colors.grey[300]!; // Gris claro para visitados
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38, width: 2),
      ),
      child: Column(
        children: List.generate(maze.length, (row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(maze[row].length, (col) {
              return GestureDetector(
                onTap: () => onCellTap(row, col),
                child: Container(
                  width: 35,
                  height: 35,
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: _getColor(maze[row][col]),
                    border: Border.all(
                      color: Colors.black12,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: _getCellIcon(maze[row][col]),
                ),
              );
            }),
          );
        }),
      ),
    );
  }

  Widget? _getCellIcon(int value) {
    switch (value) {
      case 2: // Inicio
        return const Icon(Icons.play_arrow, size: 20, color: Colors.white);
      case 3: // Fin
        return const Icon(Icons.flag, size: 20, color: Colors.white);
      default:
        return null;
    }
  }
}