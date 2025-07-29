import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/csv_page.dart';
import '../pages/maze_page.dart';
import 'benchmark_page.dart';
import '../widgets/home_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Proyecto Final de ED'),
        backgroundColor: const Color.fromARGB(255, 60, 97, 207),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeButton(
              label: 'Maze',
              icon: Icons.grid_view,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MazePage()),
              ),
            ),
            HomeButton(
              label: 'Benchmark',
              icon: Icons.bar_chart,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BenchmarkPage()),
              ),
            ),
            HomeButton(
              label: 'Datos',
              icon: Icons.bar_chart,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CsvPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}