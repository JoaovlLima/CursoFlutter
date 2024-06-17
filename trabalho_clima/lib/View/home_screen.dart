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
    print('Focus changed: ${_focusNode.hasFocus}');
    setState(() {
      _showStoredCities = _focusNode.hasFocus;
    });
  }

  Future<void> _loadStoredCities() async {
    final prefs = await SharedPreferences.getInstance();
    final storedCities = prefs.getString('cidadesArmazenadas');
    final favoriteCities = prefs.getStringList('cidadesFavoritas');
    if (storedCities != null) {
      setState(() {
        cidadesArmazenadas = json.decode(storedCities);
        print('Cidades armazenadas carregadas: $cidadesArmazenadas');
      });
    }
    if (favoriteCities != null) {
      setState(() {
        cidadesFavoritas = favoriteCities;
        print('Cidades favoritas carregadas: $cidadesFavoritas');
      });
    }
  }

  Future<void> _saveCityData(String city, Map<String, dynamic> data) async {
    cidadesArmazenadas[city] = data;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cidadesArmazenadas', json.encode(cidadesArmazenadas));
    print('Cidade salva: $city');
  }

  Future<void> _deleteCityData(String city) async {
    setState(() {
      cidadesArmazenadas.remove(city);
      cidadesFavoritas.remove(city);
      print('Cidade deletada: $city');
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cidadesArmazenadas', json.encode(cidadesArmazenadas));
    prefs.setStringList('cidadesFavoritas', cidadesFavoritas);
  }

  Future<void> _toggleFavorite(String city) async {
    setState(() {
      if (cidadesFavoritas.contains(city)) {
        cidadesFavoritas.remove(city);
        print('Cidade removida dos favoritos: $city');
      } else {
        cidadesFavoritas.add(city);
        print('Cidade adicionada aos favoritos: $city');
      }
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('cidadesFavoritas', cidadesFavoritas);
  }

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
        print('Dados do clima atualizados: $_temperature, $_velocVent, $_humidAr');
      });

      // Agora você pode usar o método toMap para obter um Map dos dados
      final Map<String, dynamic> climaMap = clima.toMap();

      // Adicione a cidade ao Map e armazene no banco de dados JSON
      climaMap['cidade'] = _controller.text;
      await _saveCityData(_controller.text, climaMap);
    } else {
      setState(() {
        _temperature = 'Falha ao carregar dados do clima';
        _velocVent = '';
        _humidAr = '';
        print('Falha ao carregar dados do clima');
      });
    }
  }

  void _onCityTapped(String city) {
    _controller.text = city;
    print('Cidade selecionada: $city');
    _getTemperature();
    _focusNode.unfocus(); // Para fechar o teclado
    setState(() {
      _showStoredCities = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                labelText: 'Digite o nome da cidade',
                hintText: 'São Paulo',
              ),
              onSubmitted: (value) => _getTemperature(),
            ),
            if (_showStoredCities)
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    boxShadow: [
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
                              icon: Icon(Icons.delete),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getTemperature,
              child: Text('Buscar Temperatura'),
            ),
            SizedBox(height: 20),
            Text(
              _temperature.isNotEmpty
                  ? 'Temperatura: $_temperature'
                  : 'Insira uma cidade para buscar a temperatura',
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
          ],
        ),
      ),
    );
  }
}

