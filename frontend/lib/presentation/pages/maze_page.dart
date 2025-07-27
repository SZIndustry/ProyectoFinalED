// lib/presentation/pages/maze_page.dart
import 'package:flutter/material.dart';
import 'package:frontend/data/models/maze_result_model.dart';
import '../controllers/maze_controller.dart';
import '../widgets/maze_grid.dart';
import '../widgets/connection_status.dart';

class MazePage extends StatefulWidget {
  const MazePage({super.key});

  @override
  State<MazePage> createState() => _MazePageState();
}

class _MazePageState extends State<MazePage> {
  final filasController = TextEditingController(text: '10');
  final columnasController = TextEditingController(text: '10');
  final MazeController _controller = MazeController();

  List<List<int>> maze = [];
  bool _showSolution = false;
  bool _checkingConnection = false;

  @override
  void initState() {
    super.initState();
    _generarMazeInicial();
    _verificarConexionInicial();
  }

  void _generarMazeInicial() {
    final filas = int.tryParse(filasController.text) ?? 10;
    final columnas = int.tryParse(columnasController.text) ?? 10;
    setState(() {
      maze = _controller.generar(filas, columnas);
    });
  }

  Future<void> _verificarConexionInicial() async {
    setState(() => _checkingConnection = true);
    await _controller.verificarConexion();
    setState(() => _checkingConnection = false);
  }

  void generarMaze() {
    final filas = int.tryParse(filasController.text) ?? 10;
    final columnas = int.tryParse(columnasController.text) ?? 10;
    setState(() {
      maze = _controller.generar(filas, columnas);
      _showSolution = false;
    });
  }

  void resolver() async {
    if (_controller.isSolving) return;

    setState(() {
      _showSolution = false;
    });

    try {
      final resultado = await _controller.resolver(
        maze: maze,
        filas: maze.length,
        columnas: maze[0].length,
      );

      setState(() {
        _controller.aplicarSolucion();
        _showSolution = true;
      });

      _mostrarDetallesResultado(resultado!);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${_controller.errorMessage}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _mostrarDetallesResultado(MazeResult resultado) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Resultado del Algoritmo"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Algoritmo: ${resultado.algoritmo.toUpperCase()}"),
            const SizedBox(height: 8),
            Text("Tiempo: ${resultado.tiempoEjecucion} ms"),
            const SizedBox(height: 8),
            Text("Nodos visitados: ${resultado.resultado.where((n) => n['tipo'] == 'visitado').length}"),
            const SizedBox(height: 8),
            Text("Longitud camino: ${resultado.resultado.where((n) => n['tipo'] == 'camino').length}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Laberinto")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ConnectionStatus(
              checking: _checkingConnection,
              controller: _controller,
              onRetry: _verificarConexionInicial,
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: filasController,
                      decoration: const InputDecoration(labelText: "Filas"),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: columnasController,
                      decoration: const InputDecoration(labelText: "Columnas"),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButtonFormField<String>(
                value: _controller.algoritmoSeleccionado,
                decoration: const InputDecoration(
                  labelText: 'Algoritmo',
                  border: OutlineInputBorder(),
                ),
                items: _controller.algoritmos.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.toUpperCase()),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _controller.cambiarAlgoritmo(newValue!);
                  });
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: generarMaze,
                    child: const Text("Generar"),
                  ),
                  ElevatedButton(
                    onPressed: _controller.isSolving ? null : resolver,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _showSolution ? Colors.green : null,
                    ),
                    child: _controller.isSolving
                        ? const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(color: Colors.white),
                              SizedBox(width: 8),
                              Text("Resolviendo"),
                            ],
                          )
                        : Text(_showSolution ? "Resuelto" : "Resolver"),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MazeGrid(
                maze: maze,
                onCellTap: (row, col) {
                  setState(() {
                    _controller.toggleCell(row, col);
                    maze = _controller.maze;
                    _showSolution = false;
                  });
                },
                isSolving: _controller.isSolving,
              ),
            ),
          ],
        ),
      ),
    );
  }
}