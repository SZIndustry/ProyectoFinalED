import 'package:flutter/material.dart';

class CsvTableWidget extends StatelessWidget {
  final List<Map<String, String>> datos;

  const CsvTableWidget({super.key, required this.datos});

  @override
  Widget build(BuildContext context) {
    if (datos.isEmpty) return const Text('No hay datos para mostrar.');

    // Obtener todas las columnas (keys) de la primera fila
    final columnas = datos.first.keys.toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: columnas
            .map((col) => DataColumn(label: Text(col, style: const TextStyle(fontWeight: FontWeight.bold))))
            .toList(),
        rows: datos.map((fila) {
          return DataRow(
            cells: columnas.map((col) {
              return DataCell(Text(fila[col] ?? ''));
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}