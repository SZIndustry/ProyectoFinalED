import 'package:flutter/material.dart';
import '../controllers/maze_controller.dart';
import '../widgets/maze_grid.dart';

class MazePage extends StatefulWidget {
  const MazePage({super.key});

  @override
  State<MazePage> createState() => _MazePageState();
}

class _MazePageState extends State<MazePage> {
  
  final MazeController _controller = MazeController();
  final TextEditingController _rowsController = TextEditingController();
  final TextEditingController _colsController = TextEditingController();
  String selectedAlgorithm = 'bfs';

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    _rowsController.dispose();
    _colsController.dispose();
    super.dispose();
  }

  void _generarMaze() {
    final filas = int.tryParse(_rowsController.text);
    final columnas = int.tryParse(_colsController.text);

    if (filas == null || columnas == null || filas <= 0 || columnas <= 0) {
      print("❌ Tamaño inválido para el laberinto");
      return;
    }

    _controller.generarLaberinto(filas, columnas);
  }

  Future<void> _resolverMaze() async {
    if (_controller.maze.isEmpty) {
      print("❌ El laberinto no ha sido generado");
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text("Resolviendo laberinto..."),
          ],
        ),
      ),
    );

    try {
      print("📤 Enviando laberinto al backend...");
      await _controller.resolver(selectedAlgorithm);
      print("📥 Datos recibidos del backend y aplicados.");
    } catch (e, stack) {
      print("❌ Error en _resolverMaze: $e");
      print(stack);
    } finally {
      if (mounted) {
        Navigator.pop(context); // cerrar loading
      }
    }
  }

String interactionMode = 'obstaculo'; // o 'iniciofin'

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laberinto'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: _rowsController,
                    decoration: InputDecoration(
                      labelText: 'Filas',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: _colsController,
                    decoration: InputDecoration(
                      labelText: 'Columnas',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                DropdownButton<String>(
                  value: selectedAlgorithm,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedAlgorithm = value;
                      });
                    }
                  },
                  items: _controller.availableAlgorithms
                      .map((alg) => DropdownMenuItem(
                            value: alg,
                            child: Text(alg.toUpperCase()),
                          ))
                      .toList(),
                ),
                DropdownButton<String>(
                  value: interactionMode,
                  items: const [
                    DropdownMenuItem(value: 'obstaculo', child: Text("Obstáculo")),
                    DropdownMenuItem(value: 'iniciofin', child: Text("Inicio/Fin")),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        interactionMode = value;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton.icon(
                  onPressed: _generarMaze,
                  icon: const Icon(Icons.grid_on),
                  label: const Text('Generar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _resolverMaze,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Resolver'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
           Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (_controller.maze.isEmpty) {
                    return const Center(child: Text('Genera un laberinto para comenzar'));
                  }

                  final rows = _controller.maze.length;
                  final cols = _controller.maze[0].length;

                  // Calcula el tamaño de cada celda basado en el espacio disponible
                  final cellWidth = constraints.maxWidth / cols;
                  final cellHeight = constraints.maxHeight / rows;
                  final cellSize = cellWidth < cellHeight ? cellWidth : cellHeight;

                  final gridWidth = cellSize * cols;
                  final gridHeight = cellSize * rows;

                  return Center(
                    child: SizedBox(
                      width: gridWidth,
                      height: gridHeight,
                      child: MazeGrid(
                        maze: _controller.maze,
                        onTapNodo: (x, y) {
                          if (interactionMode == 'obstaculo') {
                            _controller.toggleObstaculo(x, y);
                          } else if (interactionMode == 'iniciofin') {
                            _controller.seleccionarInicioFin(x, y);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}