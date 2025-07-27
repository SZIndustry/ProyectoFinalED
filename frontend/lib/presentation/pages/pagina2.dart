import 'package:flutter/material.dart';

class Pagina2 extends StatelessWidget {
  const Pagina2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualización de Algoritmos'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Text(
          'Aquí se visualizará la ejecución de BFS, DFS, etc.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
