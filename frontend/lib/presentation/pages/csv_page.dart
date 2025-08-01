import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/csv_controller.dart';

class CsvPage extends StatefulWidget {
  const CsvPage({super.key});

  @override
  State<CsvPage> createState() => _CsvPageState();
}

class _CsvPageState extends State<CsvPage> {
  @override
  void initState() {
    super.initState();
    context.read<CsvController>().cargarResumenArchivos();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CsvController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("📊 Resumen de Archivos CSV")),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: controller.cargando
                ? const Center(child: CircularProgressIndicator())
                : controller.resumenList.isEmpty
                    ? const Center(child: Text("No hay datos para mostrar"))
                    : Scrollbar(
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              headingRowColor: WidgetStateColor.resolveWith(
                                  (states) => Colors.blueGrey.shade100),
                              columns: const [
                                DataColumn(label: Text('Fecha')),
                                DataColumn(label: Text('Algoritmo')),
                                DataColumn(label: Text('Filas')),
                                DataColumn(label: Text('Columnas')),
                                DataColumn(label: Text('Nodos Visitados')),
                                DataColumn(label: Text('Nodos Camino')),
                                DataColumn(label: Text('Tiempo (ms)')),
                              ],
                              rows: List.generate(controller.resumenList.length, (index) {
                                final resumen = controller.resumenList[index];
                                return DataRow(
                                  color: WidgetStateColor.resolveWith((states) =>
                                    index % 2 == 0 ? Colors.grey.shade50 : Colors.white),
                                  cells: [
                                    DataCell(Text(resumen.fecha)),
                                    DataCell(Text(resumen.algoritmo)),
                                    DataCell(Text(resumen.filas.toString())),
                                    DataCell(Text(resumen.columnas.toString())),
                                    DataCell(Text(resumen.nodosVisitados.toString())),
                                    DataCell(Text(resumen.nodosCamino.toString())),
                                    DataCell(Text(resumen.tiempoMs.toStringAsFixed(0))),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
          ),
        );
      },
    );
  }
}