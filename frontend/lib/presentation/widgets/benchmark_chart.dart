import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../data/models/maze_benchmark_result_model.dart';

class BenchmarkChart extends StatelessWidget {
  final List<MazeBenchmarkResult> resultados;

  const BenchmarkChart({super.key, required this.resultados});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: resultados.length,
      itemBuilder: (context, index) {
        final r = resultados[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 12),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  r.algoritmo.toUpperCase(),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.center,
                      groupsSpace: 40,
                      barGroups: [
                        BarChartGroupData(x: 0, barRods: [
                          BarChartRodData(toY: r.tiempoEjecucion.toDouble(), color: Colors.blue, width: 20),
                        ], showingTooltipIndicators: [0]),
                        BarChartGroupData(x: 1, barRods: [
                          BarChartRodData(toY: r.cantidadVisitados.toDouble(), color: Colors.green, width: 20),
                        ], showingTooltipIndicators: [0]),
                        BarChartGroupData(x: 2, barRods: [
                          BarChartRodData(toY: r.longitudCamino.toDouble(), color: Colors.orange, width: 20),
                        ], showingTooltipIndicators: [0]),
                      ],
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false), 
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              switch (value.toInt()) {
                                case 0:
                                  return const Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text('Tiempo', style: TextStyle(fontSize: 12)),
                                  );
                                case 1:
                                  return const Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text('Visitados', style: TextStyle(fontSize: 12)),
                                  );
                                case 2:
                                  return const Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text('Longitud', style: TextStyle(fontSize: 12)),
                                  );
                                default:
                                  return const SizedBox.shrink();
                              }
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(show: true),
                    ),
                  )
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
