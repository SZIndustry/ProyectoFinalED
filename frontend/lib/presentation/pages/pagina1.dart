import 'package:flutter/material.dart';

class Pagina1 extends StatefulWidget {
  @override
  _Pagina1State createState() => _Pagina1State();
}

class _Pagina1State extends State<Pagina1> {
  final TextEditingController filasController = TextEditingController(text: '10');
  final TextEditingController columnasController = TextEditingController(text: '10');

  List<List<int>> maze = [];
  String selectedAlgorithm = 'BFS';
  final List<String> algorithms = ['BFS', 'DFS', 'Recursivo', 'Recursivo con Caché', 'Backtracking'];

  void generarMaze() {
    int filas = int.tryParse(filasController.text) ?? 10;
    int columnas = int.tryParse(columnasController.text) ?? 10;

    setState(() {
      maze = List.generate(filas, (i) => List.generate(columnas, (j) => 0));
      maze[0][0] = 2; // Inicio
      maze[filas - 1][columnas - 1] = 3; // Fin
    });
  }

  void resolverMaze() {
    print('Algoritmo seleccionado: $selectedAlgorithm');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ejecutando $selectedAlgorithm...')),
    );
  }

  Color getCellColor(int value) {
    switch (value) {
      case 0: return Colors.grey.shade100;      // Libre
      case 1: return Colors.grey.shade800;      // Obstáculo
      case 2: return Colors.greenAccent.shade400; // Inicio
      case 3: return Colors.redAccent.shade200; // Fin
      case 4: return Colors.blueAccent.shade100; // Camino (opcional)
      default: return Colors.grey;
    }
  }

  void toggleCell(int row, int col) {
    setState(() {
      if (maze[row][col] == 2 || maze[row][col] == 3) return;
      maze[row][col] = maze[row][col] == 0 ? 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    int rows = maze.length;
    int cols = rows > 0 ? maze[0].length : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Maze Designer', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Input de filas y columnas
            Row(
              children: [
                _buildInputField('Filas', filasController),
                SizedBox(width: 10),
                _buildInputField('Columnas', columnasController),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: generarMaze,
                  icon: Icon(Icons.grid_on),
                  label: Text('Generar'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                ),
              ],
            ),
            SizedBox(height: 12),
            // Algoritmo + Resolver
            Row(
              children: [
                Text('Algoritmo: ', style: TextStyle(fontSize: 16)),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedAlgorithm,
                  items: algorithms
                      .map((algo) => DropdownMenuItem(value: algo, child: Text(algo)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedAlgorithm = value;
                      });
                    }
                  },
                ),
                SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: resolverMaze,
                  icon: Icon(Icons.play_arrow),
                  label: Text('Resolver'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Vista del laberinto con zoom
            Expanded(
              child: maze.isEmpty
                  ? Center(child: Text('Genera un laberinto primero'))
                  : InteractiveViewer(
                      maxScale: 5,
                      minScale: 0.5,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(rows, (i) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(cols, (j) {
                              return GestureDetector(
                                onTap: () => toggleCell(i, j),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  margin: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    color: getCellColor(maze[i][j]),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.grey.shade300, width: 0.8),
                                    boxShadow: maze[i][j] == 2 || maze[i][j] == 3
                                        ? [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(1, 1))]
                                        : [],
                                  ),
                                ),
                              );
                            }),
                          );
                        }),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Expanded(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
