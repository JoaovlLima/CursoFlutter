import 'package:flutter/material.dart';

class Favoritopage extends StatelessWidget {
  final List<String> cidadesFavoritas;

  const Favoritopage({required this.cidadesFavoritas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cidades Favoritas'),
      ),
      body: ListView.builder(
        itemCount: cidadesFavoritas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cidadesFavoritas[index]),
          );
        },
      ),
    );
  }
}