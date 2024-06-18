// clima_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClimaService {
  final String apiKey;

  ClimaService(this.apiKey);

  Future<Map<String, dynamic>> obterDadosClima(String cidade) async {
    var url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cidade&appid=$apiKey');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha ao carregar dados do clima');
    }
  }
}
