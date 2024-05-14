// main.dart
import 'package:flutter/material.dart';
import 'package:trabalho_clima/services/clima_services.dart';

class PaginaFavoritos extends StatefulWidget {
  const PaginaFavoritos({super.key});

  @override
  _PaginaFavoritosState createState() => _PaginaFavoritosState();
}

class _PaginaFavoritosState extends State<PaginaFavoritos> {
  final List<String> _itens = ['London', 'New York'];
  final Set<String> _favoritos = Set<String>(); 
  final Map<String, dynamic> _clima = {};
  late ClimaService _climaService;

  @override
  void initState() {
    super.initState();
    _atualizarClima();
  }

  void _atualizarClima() async {
    for (String cidade in _itens) {
      var dadosClima = await _climaService.obterDadosClima(cidade);
      setState(() {
        _clima[cidade] = dadosClima;
      });
    }
  }

  void _toggleFavorito(String item) {
    setState(() {
      if (_favoritos.contains(item)) {
        _favoritos.remove(item);
      } else {
        _favoritos.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página de Favoritos com Clima'),
        backgroundColor: Colors.amber,
      ),
      body: Expanded(child:  
      ListView.builder(
        itemCount: _itens.length,
        itemBuilder: (context, index) {
          final item = _itens[index];
          final isFavorito = _favoritos.contains(item);
          final climaItem = _clima[item] ?? {};
          return ListTile(
            title: Text(item),
            subtitle: Text(climaItem.isNotEmpty
                ? 'Temp: ${climaItem['main']['temp']}°C'
                : 'Carregando...'),
            trailing: Icon(
              isFavorito ? Icons.favorite : Icons.favorite_border,
              color: isFavorito ? Colors.red : null,
            ),
            onTap: () {
              _toggleFavorito(item);
              _atualizarClima();

            },
          );
        },
      ),
      ),
    );
  }
}
