import 'package:exemplo_persistencia_json/Controller/livros_controller.dart';
import 'package:exemplo_persistencia_json/Model/livros_model.dart';
import 'package:flutter/material.dart';

class LivroCadastroPage extends StatefulWidget {
  @override
  _LivroCadastroPageState createState() => _LivroCadastroPageState();
}

class _LivroCadastroPageState extends State<LivroCadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final LivrosController controller = LivrosController();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController autorController = TextEditingController();
  final TextEditingController sinopseController = TextEditingController();
  final TextEditingController capaController = TextEditingController();
  final TextEditingController editoraController = TextEditingController();
  final TextEditingController isbnController = TextEditingController();
  final TextEditingController precoController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarLivros();
  }

  Future<void> _carregarLivros() async {
    await controller.carregarJson();
    setState(() {});
  }

  @override
  void dispose() {
    tituloController.dispose();
    autorController.dispose();
    sinopseController.dispose();
    capaController.dispose();
    editoraController.dispose();
    isbnController.dispose();
    precoController.dispose();
    categoriaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Livro'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: tituloController,
              decoration: const InputDecoration(labelText: "Título do Livro"),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Título não pode ser vazio";
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              controller: categoriaController,
              decoration: const InputDecoration(labelText: "Categoria, separe por vírgula"),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Categoria não pode ser vazia";
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              controller: autorController,
              decoration: const InputDecoration(labelText: "Autor"),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Autor não pode ser vazio";
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              controller: sinopseController,
              decoration: const InputDecoration(labelText: "Sinopse"),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Sinopse não pode ser vazia";
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              controller: editoraController,
              decoration: const InputDecoration(labelText: "Editora"),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Editora não pode ser vazia";
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              controller: isbnController,
              decoration: const InputDecoration(labelText: "ISBN"),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "ISBN não pode ser vazio";
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              controller: precoController,
              decoration: const InputDecoration(labelText: "Preço"),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Preço não pode ser vazio";
                } else {
                  return null;
                }
              },
            ),
            ElevatedButton(
              child: Text('Cadastrar Livro'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _cadastrarLivro();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _cadastrarLivro() {
    final livro = Livros(
      id: controller.listLivros.length + 1,
      titulo: tituloController.text,
      autor: autorController.text,
      sinopse: sinopseController.text,
      editora: editoraController.text,
      isbn: isbnController.text,
      preco: double.parse(precoController.text),
      categoria: categoriaController.text.split(','),
      capa: "img",
    );
    controller.addLivro(livro);
    controller.salvarJson();
    _cleanControllers();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Livro cadastrado com sucesso!'),
      ),
    );
  }

  void _cleanControllers() {
    tituloController.clear();
    autorController.clear();
    sinopseController.clear();
    capaController.clear();
    editoraController.clear();
    isbnController.clear();
    precoController.clear();
    categoriaController.clear();
  }
}
