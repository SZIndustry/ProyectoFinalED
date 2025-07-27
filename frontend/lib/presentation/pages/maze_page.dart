import 'package:flutter/material.dart';
import 'package:frontend/presentation/controllers/maze_controller.dart';
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
  void dispose() {
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

    setState(() {
      _controller.generarLaberinto(filas, columnas);
    });
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
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Laberinto')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _rowsController,
                    decoration: const InputDecoration(labelText: 'Filas'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: TextField(
                    controller: _colsController,
                    decoration: const InputDecoration(labelText: 'Columnas'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10),
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
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _generarMaze,
                  child: const Text('Generar laberinto'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _resolverMaze,
                  child: const Text('Resolver laberinto'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _controller.maze.isEmpty
                  ? const Center(child: Text('Genera un laberinto para comenzar'))
                  : MazeGrid(
                      maze: _controller.maze,
                      onTapNodo: (x, y) {
                        setState(() {
                          _controller.toggleObstaculo(x, y);
                        });
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}