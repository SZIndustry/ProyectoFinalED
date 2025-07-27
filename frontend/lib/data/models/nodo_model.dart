class Nodo {
  int x;
  int y;
  bool esInicio;
  bool esFin;
  bool esObstaculo;
  String tipo;

  Nodo({
    required this.x,
    required this.y,
    this.esInicio = false,
    this.esFin = false,
    this.esObstaculo = false,
    this.tipo = '',
  });

  void resetTipo() {
    if (!esInicio && !esFin && !esObstaculo) {
      tipo = '';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
      'esInicio': esInicio,
      'esFin': esFin,
      'esObstaculo': esObstaculo,
    };
  }

  factory Nodo.fromJson(Map<String, dynamic> json) {
    return Nodo(
      x: json['x'],
      y: json['y'],
      esInicio: json['esInicio'] ?? false,
      esFin: json['esFin'] ?? false,
      esObstaculo: json['esObstaculo'] ?? false,
    );
  }
}