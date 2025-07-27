import 'package:flutter/material.dart';

class Pagina3 extends StatelessWidget {
  const Pagina3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Benchmark de Algoritmos'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text(
          'Aquí se mostrarán comparaciones y tiempos.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
