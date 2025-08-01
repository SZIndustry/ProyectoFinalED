import 'package:flutter/material.dart';
import '../../data/models/nodo_model.dart';

class MazeGrid extends StatelessWidget {
  final List<List<Nodo>> maze;
  final void Function(int x, int y) onTapNodo;

  const MazeGrid({
    super.key,
    required this.maze,
    required this.onTapNodo,
  });

  Color _getColor(Nodo nodo) {
  if (nodo.esInicio) return Colors.green;
  if (nodo.esFin) return Colors.red;
  if (nodo.esObstaculo) return Colors.black;
  if (nodo.tipo == 'camino') return Colors.yellow;   
  if (nodo.tipo == 'visitado') return Colors.grey;     
  return Colors.white;
}


  @override
  Widget build(BuildContext context) {
    if (maze.isEmpty) {
      return const Center(child: Text("Genera el laberinto para empezar"));
    }

    int filas = maze.length;
    int columnas = maze[0].length;

    return AspectRatio(
      aspectRatio: columnas / filas,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columnas,
        ),
        itemCount: filas * columnas,
        itemBuilder: (context, index) {
          int x = index ~/ columnas;
          int y = index % columnas;
          Nodo nodo = maze[x][y];

          return GestureDetector(
            onTap: () => onTapNodo(x, y),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: _getColor(nodo),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black12),
              ),
            ),
          );
        },
      ),
    );
  }
}