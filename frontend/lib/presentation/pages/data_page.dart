import 'package:flutter/material.dart';
import 'package:frontend/data/models/almacen_resultado.dart';


class DataPage extends StatelessWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualización de Algoritmos'),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.builder(
        itemCount: historialResultados.length,
        itemBuilder: (context, index) {
          final resultado = historialResultados[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            elevation: 4,
            child: ListTile(
              leading: Icon(Icons.bolt, color: Colors.orange),
              title: Text(resultado.algoritmo),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Duración: ${resultado.duracion.inMilliseconds} ms'),
                  Text('Pasos: ${resultado.pasos}'),
                  Text('Nodos Visitados: ${resultado.nodosVisitados}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
