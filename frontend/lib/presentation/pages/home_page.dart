import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/csv_page.dart';
import '../pages/maze_page.dart';
import 'benchmark_page.dart';
import '../widgets/home_button.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _mostrarCreditos(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFEAF1FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Center(
          child: Text(
            '👥 Créditos del Proyecto',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Desarrolladores:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                const url = 'https://github.com/Juan-Jim'; 
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                }
              },
              child: const Text(
                '• Juan Jimenez',
                style: TextStyle(
                  color: Colors.blueAccent,
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 6),
            InkWell(
              onTap: () async {
                const url = 'https://github.com/SZIndustry'; 
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                }
              },
              child: const Text(
                '• Cristopher Salinas',
                style: TextStyle(
                  color: Colors.blueAccent,
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
              label: const Text("Cerrar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
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
        ),
        Positioned(
          top: 40,
          right: 20,
          child: ElevatedButton.icon(
            onPressed: () => _mostrarCreditos(context),
            icon: const Icon(Icons.info_outline),
            label: const Text('Créditos'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 6,
              shadowColor: Colors.black45,
            ),
          ),
        ),
      ],
    );
  }
}
