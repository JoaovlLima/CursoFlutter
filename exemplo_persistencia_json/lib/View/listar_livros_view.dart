import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Controller/livros_controller.dart';

class ListarLivrosScreen extends StatefulWidget {
  const ListarLivrosScreen({super.key});

  @override
  State<ListarLivrosScreen> createState() => _ListarLivrosScreenState();
}

class _ListarLivrosScreenState extends State<ListarLivrosScreen> {
  final LivrosController _controller = LivrosController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Livros'),
      ),
      body: Expanded(
        child: Padding(padding: 
        EdgeInsets.all(12),
        child: //lista de livros
        ListView.builder(
          itemCount: _controller.listLivros.length,
          itemBuilder: (context, index) {
          ListTile(
            leading: Image.file(File( _controller.listLivros[index].capa)),
            title: Text(_controller.listLivros[index].titulo),
            subtitle: Text(_controller.listLivros[index].autor),
            );
            return null;
          }
        )
      )));
    
  }
}