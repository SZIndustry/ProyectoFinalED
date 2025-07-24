import 'package:flutter/material.dart';
import 'package:frontend/widgets/botones_Panel.dart';
import 'services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyecto Final ED',
      home: Scaffold(
        appBar: AppBar(title: Text('Proyecto Final ED')),
        body: Center(
          child: BotonesPanel(), // Aquí usas el widget con tus botones
        ),
      ),
    );
  }
}
             