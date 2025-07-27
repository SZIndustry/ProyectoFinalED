// lib/presentation/widgets/connection_status.dart
import 'package:flutter/material.dart';
import '../controllers/maze_controller.dart';

class ConnectionStatus extends StatelessWidget {
  final bool checking;
  final MazeController controller;
  final VoidCallback onRetry;

  const ConnectionStatus({
    super.key,
    required this.checking,
    required this.controller,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (checking)
            const Row(
              children: [
                Text("Verificando conexión..."),
                SizedBox(width: 8),
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ],
            )
          else if (controller.hasError)
            Row(
              children: [
                const Icon(Icons.error, color: Colors.red),
                const SizedBox(width: 8),
                Text(
                  controller.errorMessage ?? "Error de conexión",
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: onRetry,
                  child: const Text("Reintentar"),
                ),
              ],
            )
          else
            const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8),
                Text("Conectado al backend", style: TextStyle(color: Colors.green)),
              ],
            ),
        ],
      ),
    );
  }
}