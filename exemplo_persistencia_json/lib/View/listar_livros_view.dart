import 'dart:io';
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
  void initState() {
    super.initState();
    _carregarLivros();
  }

  Future<void> _carregarLivros() async {
    await _controller.carregarJson();
    setState(() {
      print("Número de livros carregados: ${_controller.listLivros.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Livros'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: _controller.listLivros.isEmpty
            ? Center(child: Text('Nenhum livro encontrado.'))
            : ListView.builder(
                itemCount: _controller.listLivros.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: _controller.listLivros[index].capa != "img"
                        ? Image.file(File(_controller.listLivros[index].capa))
                        : Icon(Icons.book),
                    title: Text(_controller.listLivros[index].titulo),
                    subtitle: Text(_controller.listLivros[index].autor),
                  );
                },
              ),
      ),
    );
  }
}
