class Nodo {
  final int x;
  final int y;
  final bool esInicio;
  final bool esFin;
  final bool esObstaculo;

  Nodo({
    required this.x,
    required this.y,
    required this.esInicio,
    required this.esFin,
    required this.esObstaculo,
  });

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
      'esInicio': esInicio,
      'esFin': esFin,
      'esObstaculo': esObstaculo,
    };
  }
}