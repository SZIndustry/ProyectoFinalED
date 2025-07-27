import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/mensaje_page.dart';
//import 'package:frontend/widgets/botones_Panel.dart';
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
      home: MensajePage(),
    );
  }
}
             