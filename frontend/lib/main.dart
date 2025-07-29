import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/pages/home_page.dart';
import 'presentation/controllers/maze_controller.dart';
import 'presentation/controllers/benchmark_controller.dart';
import 'presentation/controllers/csv_controller.dart';

void main() {
  runApp(const ProyectoFinalApp());
}

class ProyectoFinalApp extends StatelessWidget {
  const ProyectoFinalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MazeController()),
        ChangeNotifierProvider(create: (_) => BenchmarkController()),
        ChangeNotifierProvider(create: (_) => CsvController()),
      ],
      child: MaterialApp(
        title: 'Proyecto Final',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}