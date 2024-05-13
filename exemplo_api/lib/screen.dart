import 'package:exemplo_api/service.dart';
import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}


// Classe que representa o estado do widget de previsão do tempo.
class _WeatherScreenState extends State<WeatherScreen> {
  // Instância do serviço WeatherService para obter os dados de previsão do tempo.
  final WeatherService _weatherService = WeatherService(
    apiKey: '681126f28e7d6fa3a7cfe0da0671e599', // Chave de API para acesso à API de previsão do tempo.
    baseUrl: 'https://api.openweathermap.org/data/2.5', // URL base da API de previsão do tempo.
  );


  // Mapa que armazenará os dados de previsão do tempo.
  late Map<String, dynamic> _weatherData;



  // Método chamado quando o estado é inicializado.
  @override
  void initState() {
    super.initState();
    _weatherData = {
    'name': '', // inicializa 'name' como uma string vazia
    'main': {'temp': 0} // inicializa 'main' como um mapa com 'temp' como 0
  };
  }

 Future<void> _fetchWeatherData(String city) async {
    try {

      final weatherData = await _weatherService.getWeather(city);
      setState(() {
        _weatherData = weatherData;
      });
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

final TextEditingController _cidadeController = TextEditingController();

  // Método responsável por construir a interface de usuário do widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previsão do Tempo'),
        // Título da barra de aplicativos.
      ),
      body: Expanded(child: Column(children: [
        TextField(
          controller: _cidadeController,
          decoration: 
          InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Digite a cidade',
          ),
        ),
      
        
        
        
        SizedBox(height: 20,),
        
        ElevatedButton(
  onPressed: () async {
    await _fetchWeatherData(_cidadeController.text);
    // Certifique-se de que _fetchWeatherData é chamado com 'await' para esperar pelos dados.
    if (_weatherData != null) {
      // Verifique se _weatherData não é nulo antes de acessar seus dados.
      setState(() {
        // Atualize a interface do usuário com os novos dados.
        Text('City: ${_weatherData['name']}');
        Text('Temperature: ${(_weatherData['main']['temp'] - 273).toStringAsFixed(2)} °C');
        Text('Description: ${_weatherData['weather'][0]['description']}');
      });
    }
  },
  child: Text('Buscar'),
),
 _weatherData == null
      // Verifica se os dados de previsão do tempo foram carregados.
          ? const Center(
              child: CircularProgressIndicator(),
              // Exibe um indicador de progresso enquanto os dados estão sendo carregados.
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('City: ${_weatherData['name']}'), // Exibe o nome da cidade.
                  Text('Temperature: ${(_weatherData['main']['temp']-273).toStringAsFixed(2)}°C'),
                  Text(
                      'Description: ${_weatherData['weather'][0]['description']}'), // Exibe a descrição do clima.
                ],
              ),
            ),
       
      ],),)
     
    );
  }
}


