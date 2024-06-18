import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  final String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey = '20692ba35023d0831d4467248004ce39';

  Future<Map<String, dynamic>> getTemperature(String city) async {
    final response = await http.get(Uri.parse('$apiUrl?q=$city&appid=$apiKey'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar dados do clima');
    }
  }
}

void main() async {
  WeatherService service = WeatherService();
  Map<String, dynamic> temperatureData = await service.getTemperature('São Paulo');
  print('Temperatura: ${temperatureData['main']['temp']}');
}
