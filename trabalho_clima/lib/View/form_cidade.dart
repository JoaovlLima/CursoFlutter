import 'package:flutter/material.dart';

class CidadesArmazenadasList extends StatelessWidget {
  final Map<String, dynamic> cidadesArmazenadas;

  CidadesArmazenadasList({required this.cidadesArmazenadas});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cidadesArmazenadas.keys.length,
      itemBuilder: (context, index) {
        String cidade = cidadesArmazenadas.keys.elementAt(index);
        return Card(
          child: ListTile(
            title: Text(cidade),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Este botão precisa de uma função callback para remover a cidade
                // Como este é um StatelessWidget, ele não pode chamar setState diretamente
                // Você precisará passar uma função callback do StatefulWidget pai
              },
            ),
          ),
        );
      },
    );
  }
}
