import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../data/models/maze_benchmark_result_model.dart';

class BenchmarkChart extends StatelessWidget {
  final List<MazeBenchmarkResult> resultados;

  const BenchmarkChart({super.key, required this.resultados});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tarjetas individuales por algoritmo
        Expanded(
          child: ListView.builder(
            itemCount: resultados.length,
            itemBuilder: (context, index) {
              final r = resultados[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                                sideTitles: SideTitles(
                                  showTitles: false,
                                  interval: 10,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toInt().toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),
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
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Comparación final: Nodos visitados vs Tiempo',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LineChart(
                LineChartData(
                  lineBarsData: resultados.asMap().entries.map((entry) {
                    final index = entry.key;
                    final r = entry.value;
                    final color = Colors.primaries[index % Colors.primaries.length];
                    return LineChartBarData(
                      spots: [
                        FlSpot(r.tiempoEjecucion.toDouble(), r.cantidadVisitados.toDouble()),
                      ],
                      isCurved: false,
                      barWidth: 4,
                      color: color,
                      dotData: FlDotData(show: true),
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                        interval: 10,
                        getTitlesWidget: (value, meta) => Text(value.toInt().toString()),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                        interval: 0.0001, // ← escala más detallada para segundos
                        getTitlesWidget: (value, meta) => Text(value.toStringAsFixed(1)),
                      ),
                    ),
                  ),
                  minX: 0,
                  maxX: resultados.map((r) => r.tiempoEjecucion).reduce((a, b) => a > b ? a : b).toDouble() + 0.2,
                  minY: 0,
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                ),
              )
          ),
        ),
        // Leyenda con nombre y color
        Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 12,
            runSpacing: 8,
            children: resultados.asMap().entries.map((entry) {
              final index = entry.key;
              final r = entry.value;
              final color = Colors.primaries[index % Colors.primaries.length];
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 12, height: 12, color: color),
                  const SizedBox(width: 6),
                  Text(r.algoritmo),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
