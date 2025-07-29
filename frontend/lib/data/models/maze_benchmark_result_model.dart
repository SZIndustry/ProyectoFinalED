class MazeBenchmarkResult {
  final String algoritmo;
  final int tiempoEjecucion;
  final int cantidadVisitados;
  final int longitudCamino;

  MazeBenchmarkResult({
    required this.algoritmo,
    required this.tiempoEjecucion,
    required this.cantidadVisitados,
    required this.longitudCamino,
  });

  factory MazeBenchmarkResult.fromJson(Map<String, dynamic> json) {
    return MazeBenchmarkResult(
      algoritmo: json['algoritmo'],
      tiempoEjecucion: json['tiempoEjecucion'],
      cantidadVisitados: json['cantidadVisitados'],
      longitudCamino: json['longitudCamino'],
    );
  }
}