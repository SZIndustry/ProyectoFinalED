import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/benchmark_card.dart';
import 'package:frontend/presentation/widgets/benchmark_chart.dart';
import 'package:frontend/presentation/widgets/maze_grid.dart';
import 'package:provider/provider.dart';

import '../../presentation/controllers/maze_controller.dart';
import '../../presentation/controllers/benchmark_controller.dart';
import '../../data/models/nodo_model.dart';

class BenchmarkPage extends StatefulWidget {
  const BenchmarkPage({super.key});

  @override
  State<BenchmarkPage> createState() => _BenchmarkPageState();
}

class _BenchmarkPageState extends State<BenchmarkPage> {
  final TextEditingController _rowsController = TextEditingController();
  final TextEditingController _colsController = TextEditingController();
  String interactionMode = 'obstaculo';

  void _generarLaberinto(MazeController mazeCtrl) {
    final filas = int.tryParse(_rowsController.text);
    final columnas = int.tryParse(_colsController.text);

    if (filas == null || columnas == null || filas <= 0 || columnas <= 0) {
      print("❌ Tamaño inválido para el laberinto");
      return;
    }

    try {
      mazeCtrl.generarLaberinto(filas, columnas);
    } catch (e, stack) {
      print("❌ Error al generar laberinto: $e");
      print(stack);
    }
  }

  Future<void> _ejecutarBenchmark(
      BenchmarkController benchCtrl, List<List<Nodo>> maze) async {
    try {
      print("📤 Ejecutando benchmark...");
      await benchCtrl.ejecutarBenchmark(maze);
      print("📥 Resultados recibidos del backend");
    } catch (e, stack) {
      print("❌ Error al ejecutar benchmark: $e");
      print(stack);
    } finally {
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final mazeCtrl = Provider.of<MazeController>(context);
    final benchCtrl = Provider.of<BenchmarkController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Benchmark Laberinto')),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Generador (izquierda)
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Tamaño del laberinto"),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _rowsController,
                          decoration: const InputDecoration(labelText: 'Filas'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _colsController,
                          decoration:
                              const InputDecoration(labelText: 'Columnas'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  DropdownButton<String>(
                    value: interactionMode,
                    items: const [
                      DropdownMenuItem(
                          value: 'obstaculo', child: Text("Modo Obstáculo")),
                      DropdownMenuItem(
                          value: 'iniciofin', child: Text("Modo Inicio/Fin")),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          interactionMode = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.grid_on),
                    label: const Text("Generar Laberinto"),
                    onPressed: () => _generarLaberinto(mazeCtrl),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.speed),
                    label: const Text("Ejecutar Benchmark"),
                    onPressed: mazeCtrl.maze.isNotEmpty
                        ? () => _ejecutarBenchmark(benchCtrl, mazeCtrl.maze)
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: mazeCtrl.maze.isNotEmpty
                        ? MazeGrid(
                            maze: mazeCtrl.maze,
                            onTapNodo: (x, y) {
                              if (interactionMode == 'obstaculo') {
                                mazeCtrl.toggleObstaculo(x, y);
                              } else {
                                mazeCtrl.seleccionarInicioFin(x, y);
                              }
                            },
                          )
                        : const Center(
                            child: Text("Genera un laberinto para interactuar")),
                  ),
                ],
              ),
            ),
          ),

          // 🔹 Resultados (centro)
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: benchCtrl.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : benchCtrl.resultados.isEmpty
                      ? const Center(
                          child:
                              Text("Ejecuta el benchmark para ver resultados"))
                      : ListView(
                          children: benchCtrl.resultados
                              .map((r) => BenchmarkCard(result: r))
                              .toList(),
                        ),
            ),
          ),

          // 🔹 Gráfica (derecha)
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: benchCtrl.resultados.isNotEmpty
                  ? BenchmarkChart(resultados: benchCtrl.resultados)
                  : const Center(
                      child: Text("Genera benchmark para mostrar gráfica")),
            ),
          ),
        ],
      ),
    );
  }
}