import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CsvResumen {
  final String fecha;
  final String algoritmo;
  final int filas;
  final int columnas;
  final int nodosVisitados;
  final int nodosCamino;
  final double tiempoMs;  

  CsvResumen({
    required this.fecha,
    required this.algoritmo,
    required this.filas,
    required this.columnas,
    required this.nodosVisitados,
    required this.nodosCamino,
    required this.tiempoMs,  
  });
}

class CsvController extends ChangeNotifier {
  List<CsvResumen> resumenList = [];
  bool cargando = false;

  final String baseUrl = 'http://localhost:8081/api/logs';

  Future<List<String>> _fetchFileNames() async {
    final url = Uri.parse('$baseUrl/list');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.cast<String>();
    } else {
      throw Exception('Error al obtener lista de archivos');
    }
  }

  Future<String> _fetchCsvRaw(String filename) async {
    final url = Uri.parse('$baseUrl/file/$filename');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error al obtener contenido CSV $filename');
    }
  }

  CsvResumen _procesarResumen(String csvRaw) {
    final lines = csvRaw.split('\n');
    if (lines.isEmpty) throw Exception("CSV vacío");

    final headers = lines.first.split(',');

    // Variables para resumen
    String fecha = '';
    String algoritmo = '';
    int filas = 0;
    int columnas = 0;
    int nodosVisitados = 0;
    int nodosCamino = 0;
    double tiempoMs = 0;

    for (var i = 1; i < lines.length; i++) {
      final line = lines[i].trim();
      if (line.isEmpty) continue;

      final cols = line.split(',');

      if (cols.length != headers.length) continue;

      // Mapa para acceder por nombre
      final Map<String, String> row = {};
      for (var j = 0; j < headers.length; j++) {
        row[headers[j]] = cols[j];
      }

      // Tomar datos fijos que son iguales en todas filas
      fecha = row['fecha'] ?? fecha;
      algoritmo = row['algoritmo'] ?? algoritmo;
      filas = int.tryParse(row['filas'] ?? '') ?? filas;
      columnas = int.tryParse(row['columnas'] ?? '') ?? columnas;

      final tipoDato = row['tipoDato'] ?? '';

      if (tipoDato == 'visitado') {
        nodosVisitados++;
      } else if (tipoDato == 'camino') {
        nodosCamino++;
      }

      // Tiempo ejecución (última fila que tenga valor)
      final tiempoStr = row['tiempoEjecucion(ms)'] ?? '';
      if (tiempoStr.isNotEmpty) {
        tiempoMs = double.tryParse(tiempoStr) ?? tiempoMs;
      }
    }

    return CsvResumen(
      fecha: fecha,
      algoritmo: algoritmo,
      filas: filas,
      columnas: columnas,
      nodosVisitados: nodosVisitados,
      nodosCamino: nodosCamino,
      tiempoMs: tiempoMs / 1000.0,
    );
  }

  Future<void> cargarResumenArchivos() async {
    cargando = true;
    notifyListeners();

    try {
      final archivos = await _fetchFileNames();
      List<CsvResumen> resumenes = [];

      for (final archivo in archivos) {
        final csvRaw = await _fetchCsvRaw(archivo);
        final resumen = _procesarResumen(csvRaw);
        resumenes.add(resumen);
      }

      resumenList = resumenes;
    } catch (e) {
      resumenList = [];
      print('Error cargando resumen CSVs: $e');
    }

    cargando = false;
    notifyListeners();
  }
}