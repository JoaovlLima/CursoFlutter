import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trabalho_clima/Model/clima_model.dart';
import 'package:trabalho_clima/View/fav_page.dart';

class WeatherSearchPage extends StatefulWidget {
  @override
  _WeatherSearchPageState createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _temperature = '';
  String _humidAr = '';
  String _velocVent = '';
  bool _showStoredCities = true;
  double? _currentTemp;

  Map<String, dynamic> cidadesArmazenadas = {};
  List<String> cidadesFavoritas = [];

  @override
  void initState() {
    super.initState();
    _loadStoredCities();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      // Mantenha a lista de cidades visível mesmo quando o foco é perdido
      Future.delayed(Duration(milliseconds: 1), () {
        if (!_focusNode.hasFocus) {
          setState(() {
            _showStoredCities = true;
          });
        }
      });
    }
  }

  Future<void> _loadStoredCities() async {
    final prefs = await SharedPreferences.getInstance();
    final storedCities = prefs.getString('cidadesArmazenadas');
    final favoriteCities = prefs.getStringList('cidadesFavoritas');
    if (storedCities != null) {
      setState(() {
        cidadesArmazenadas = json.decode(storedCities);
      });
    }
    if (favoriteCities != null) {
      setState(() {
        cidadesFavoritas = favoriteCities;
      });
    }
  }

  Future<void> _saveCityData(String city, Map<String, dynamic> data) async {
    cidadesArmazenadas[city] = data;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cidadesArmazenadas', json.encode(cidadesArmazenadas));
  }

  Future<void> _deleteCityData(String city) async {
    setState(() {
      cidadesArmazenadas.remove(city);
      cidadesFavoritas.remove(city);
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cidadesArmazenadas', json.encode(cidadesArmazenadas));
    prefs.setStringList('cidadesFavoritas', cidadesFavoritas);
  }

  Future<void> _toggleFavorite(String city) async {
    setState(() {
      if (cidadesFavoritas.contains(city)) {
        cidadesFavoritas.remove(city);
      } else {
        cidadesFavoritas.add(city);
      }
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('cidadesFavoritas', cidadesFavoritas);
  }

  Future<void> _getTemperature() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=${_controller.text}&appid=e83b3c4c08285bf87b99f9bbc0abe3f0&units=metric'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final clima = Clima.fromJson(data);

      setState(() {
        _temperature = '${clima.temp} °C';
        _velocVent = '${clima.velocVent} m/s';
        _humidAr = '${clima.humidAr}%';
        _currentTemp = clima.temp;
        _showStoredCities = false; // Esconder a lista de cidades armazenadas após a busca
      });

      final Map<String, dynamic> climaMap = clima.toMap();
      climaMap['cidade'] = _controller.text;
      await _saveCityData(_controller.text, climaMap);
    } else {
      setState(() {
        _temperature = 'Falha ao carregar dados do clima';
        _velocVent = '';
        _humidAr = '';
        _currentTemp = null;
      });
    }
  }

  void _onCityTapped(String city) {
    _controller.text = city;
    _getTemperature();
    _focusNode.unfocus(); // Para fechar o teclado
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Favoritopage(cidadesFavoritas: cidadesFavoritas)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                labelText: 'Digite o nome da cidade',
                hintText: 'São Paulo',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _getTemperature,
                ),
              ),
              onSubmitted: (value) => _getTemperature(),
            ),
            const SizedBox(height: 20),
            if (_showStoredCities)
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    itemCount: cidadesArmazenadas.length,
                    itemBuilder: (context, index) {
                      String city = cidadesArmazenadas.keys.elementAt(index);
                      Map<String, dynamic> data = cidadesArmazenadas[city];
                      bool isFavorite = cidadesFavoritas.contains(city);
                      return ListTile(
                        title: Text(city),
                        subtitle: Text('Temperatura: ${data['temp']} °C'),
                        onTap: () => _onCityTapped(city),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                              onPressed: () {
                                _toggleFavorite(city);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _deleteCityData(city);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getTemperature,
              child: const Text('Buscar Temperatura'),
            ),
            const SizedBox(height: 20),
            if (_temperature.isNotEmpty)
              Column(
                children: [
                  Text(
                    'Temperatura: $_temperature',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text(
                    _velocVent.isNotEmpty ? 'Velocidade do Vento: $_velocVent' : '',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text(
                    _humidAr.isNotEmpty ? 'Umidade do Ar: $_humidAr' : '',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  if (_currentTemp != null)
                    Image.asset(
                      _currentTemp! >= 25 ? 'imagens/img_hot.png' : 'imagens/img_cold.png',
                      height: 200,
                      width: 200,
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
