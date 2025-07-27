// lib/data/models/maze_result_model.dart
class MazeResult {
  final List<Map<String, dynamic>> resultado;
  final int tiempoEjecucion;
  final String algoritmo;

  MazeResult({
    required this.resultado,
    required this.tiempoEjecucion,
    required this.algoritmo,
  });

  factory MazeResult.fromJson(Map<String, dynamic> json) {
    return MazeResult(
      resultado: List<Map<String, dynamic>>.from(json['resultado']),
      tiempoEjecucion: json['tiempoEjecucion'],
      algoritmo: json['algoritmo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resultado': resultado,
      'tiempoEjecucion': tiempoEjecucion,
      'algoritmo': algoritmo,
    };
  }

  @override
  String toString() {
    return 'MazeResult{resultado: $resultado, tiempoEjecucion: $tiempoEjecucion ms, algoritmo: $algoritmo}';
  }
}