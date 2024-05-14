import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:trabalho_clima/Model/clima_model.dart';
import 'package:trabalho_clima/View/form_cidade.dart';


class WeatherSearchPage extends StatefulWidget {
  @override
  _WeatherSearchPageState createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  final TextEditingController _controller = TextEditingController();
  String _temperature = '';
  String _humidAr = '';
  String _velocVent = '';

  Map<String, dynamic> cidadesArmazenadas = {}; 


  Future<void> _getTemperature() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=${_controller.text}&appid=b9ebe666087f299f5e2aad3a03d093b6&units=metric'));
   if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final clima = Clima.fromJson(data);

    // Atualize o estado com os novos dados
    setState(() {
      _temperature = '${clima.temp} °C';
      _velocVent = '${clima.velocVent} m/s';
      _humidAr = '${clima.humidAr}%';
    });

    // Agora você pode usar o método toMap para obter um Map dos dados
    final Map<String, dynamic> climaMap = clima.toMap();

    // Adicione a cidade ao Map
    climaMap['cidade'] = _controller.text;
     cidadesArmazenadas[_controller.text] = true;

    // Faça o que precisar com o climaMap, como armazenar em um banco de dados ou enviar para outro lugar
  } else {
    setState(() {
      _temperature = 'Falha ao carregar dados do clima';
      _velocVent = '';
      _humidAr = '';
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Digite o nome da cidade',
                hintText: 'São Paulo',
              ),
              onSubmitted: (value) => _getTemperature(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getTemperature,
              child: Text('Buscar Temperatura'),
            ),
            SizedBox(height: 50),
            Text(
              _temperature.isNotEmpty ? 'Temperatura: $_temperature' : 'Insira uma cidade para buscar a temperatura',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              _velocVent.isNotEmpty ? 'Velocidade do Vento: $_velocVent' : '',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              _humidAr.isNotEmpty ? 'Umidade do Ar: $_humidAr' : '',
              style: TextStyle(fontSize: 24),

            ),
            Expanded(
            child: CidadesArmazenadasList(cidadesArmazenadas: cidadesArmazenadas),
          ),
         
          ], 
        ), 
      ),
    );
    
  }
  
}
