import 'package:flutter/material.dart';
import 'services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter + Spring Boot',
      home: Scaffold(
        appBar: AppBar(title: Text('Conexión a Backend')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text("Probar GET"),
                onPressed: () async {
                  final msg = await api.fetchHello();
                  print("Respuesta: $msg");
                },
              ),
              ElevatedButton(
                child: Text("Probar POST"),
                onPressed: () async {
                  final msg = await api.sendData({
                    "nombre": "Flutter",
                    "tipo": "Web"
                  });
                  print("Respuesta: $msg");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}