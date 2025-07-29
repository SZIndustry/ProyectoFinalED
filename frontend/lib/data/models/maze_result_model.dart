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
      resultado: (json['resultado'] as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList(),
      tiempoEjecucion: json['tiempoEjecucion'],
      algoritmo: json['algoritmo'],
    );
  }
  
}