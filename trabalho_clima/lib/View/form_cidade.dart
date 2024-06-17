import 'package:flutter/material.dart';

class CidadesArmazenadasList extends StatelessWidget {
  final Map<String, dynamic> cidadesArmazenadas;
  final Function(String) onDeleteCity;
  final Function(String) onToggleFavorite;
  final List<String> cidadesFavoritas;

  CidadesArmazenadasList({
    required this.cidadesArmazenadas,
    required this.onDeleteCity,
    required this.onToggleFavorite,
    required this.cidadesFavoritas,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cidadesArmazenadas.keys.length,
      itemBuilder: (context, index) {
        String cidade = cidadesArmazenadas.keys.elementAt(index);
        bool isFavorite = cidadesFavoritas.contains(cidade);
        return Card(
          child: ListTile(
            title: Text(cidade),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                  onPressed: () {
                    onToggleFavorite(cidade);
                    print('Favorito alternado para: $cidade');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    onDeleteCity(cidade);
                    print('Cidade deletada: $cidade');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
