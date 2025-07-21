import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://172.16.212.169:8081"; // IP del backend

  Future<String> fetchHello() async {
    final response = await http.get(Uri.parse('$baseUrl/'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Error al obtener saludo");  
    }
  }

  Future<String> sendData(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/send-data'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Error al enviar datos");
    }
  }
}