class Resultado {
  final String algoritmo;
  final Duration duracion;
  final int pasos;
  final int nodosVisitados;

  Resultado({
    required this.algoritmo,
    required this.duracion,
    required this.pasos,
    required this.nodosVisitados,
  });
}
