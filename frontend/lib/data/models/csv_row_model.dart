class CsvRowModel {
  final String fecha;
  final String algoritmo;
  final int filas;
  final int columnas;
  final String tipoDato;
  final int? x;
  final int? y;
  final bool? esInicio;
  final bool? esFin;
  final bool? esObstaculo;
  final String? tiempoEjecucion;

  CsvRowModel({
    required this.fecha,
    required this.algoritmo,
    required this.filas,
    required this.columnas,
    required this.tipoDato,
    this.x,
    this.y,
    this.esInicio,
    this.esFin,
    this.esObstaculo,
    this.tiempoEjecucion,
  });

  factory CsvRowModel.fromCsv(List<String> fields) {
    return CsvRowModel(
      fecha: fields[0],
      algoritmo: fields[1],
      filas: int.tryParse(fields[2]) ?? 0,
      columnas: int.tryParse(fields[3]) ?? 0,
      tipoDato: fields[4],
      x: int.tryParse(fields[5]),
      y: int.tryParse(fields[6]),
      esInicio: fields[7].toLowerCase() == 'true',
      esFin: fields[8].toLowerCase() == 'true',
      esObstaculo: fields[9].toLowerCase() == 'true',
      tiempoEjecucion: fields.length > 10 ? fields[10].trim() : null,
    );
  }
}