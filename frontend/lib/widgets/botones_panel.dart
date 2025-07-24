import 'package:flutter/material.dart';
import '../services/api_service.dart';

class BotonesPanel extends StatelessWidget {
  final ApiService api = ApiService(); // Instancia de tu servicio

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Botón 1
        ElevatedButton(
          child: Text("Botón hola"),
          onPressed: () async {
            try {
              final msg = await api.fetchHello();
              print("Respuesta Hola: $msg");
            } catch (e) {
              print("Error h: $e");
            }
          },
        ),
        SizedBox(height: 10),

        // Botón 2
        ElevatedButton(
          child: Text("Botón hola2"),
          onPressed: () async {
            try {
              final msg = await api.fetchHello();
              print("Respuesta Hola2: $msg");
            } catch (e) {
              print("Error h: $e");
            }
          },
        ),
        SizedBox(height: 10),

        // Botón 3
        ElevatedButton(
          child: Text("Botón hola3"),
          onPressed: () async {
            try {
              final msg = await api.fetchHello();
              print("Respuesta Hola3: $msg");
            } catch (e) {
              print("Error h: $e");
            }
          },
        ),
      ],
    );
  }
}
