import 'package:flutter/material.dart';

class LivroCadastroPage extends StatefulWidget {
  @override
  LivroCadastroPageState createState() => LivroCadastroPageState();
}

class _LivroCadastroPageState extends State<LivroCadastroPage> {
  final _formKey = GlobalKey<FormState>();
  // Controladores para os campos de texto
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController autorController = TextEditingController();
  final TextEditingController sinopseController = TextEditingController();
  final TextEditingController capaController = TextEditingController();
  final TextEditingController editoraController = TextEditingController();
  final TextEditingController isbnController = TextEditingController();
  final TextEditingController precoController = TextEditingController();

  String? categoriaSelecionada; // Categoria padrão selecionada
   final List<String> categorias = [
    'Ficção',
    'Não-ficção',
    'Autoajuda',
    'Educação',
    'Mistério',
    'Fantasia',
    'Ciência',
    'História',
    // Adicione mais categorias conforme necessário
  ];

  @override
  void dispose() {
    // Limpando os controladores quando o widget for desmontado
    tituloController.dispose();
    autorController.dispose();
    sinopseController.dispose();
    capaController.dispose();
    editoraController.dispose();
    isbnController.dispose();
    precoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Livro'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: tituloController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            // ... Outros campos de texto com seus respectivos controladores ...
            DropdownButtonFormField(
              value: categoriaSelecionada,
              decoration: InputDecoration(labelText: 'Categoria'),
              items: categorias.map((String categoria) {
                return DropdownMenuItem(
                  value: categoria,
                  child: Text(categoria),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  categoriaSelecionada = newValue;
                });
              },
            ),
            // ... Restante dos campos de texto ...
            ElevatedButton(
              child: Text('Cadastrar Livro'),
              onPressed: () {
              
              },
            ),
          ],
        ),
      ),
    );
  }
}
