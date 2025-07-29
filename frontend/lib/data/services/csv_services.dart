import 'package:http/http.dart' as http;

class CsvService {
  final String baseUrl = 'http://localhost:8081/api/logs/list';

  Future<List<String>> listarArchivos() async {
    final url = Uri.parse('$baseUrl/list');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = response.body;
      final cleaned = body.replaceAll('[', '').replaceAll(']', '').replaceAll('"', '');
      return cleaned.split(',').map((e) => e.trim()).where((e) => e.endsWith('.csv')).toList();
    } else {
      throw Exception('No se pudieron obtener los archivos CSV');
    }
  }

  Future<String> obtenerContenido(String filename) async {
    final url = Uri.parse('$baseUrl/file/$filename');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error al obtener el contenido del archivo $filename');
    }
  }
}