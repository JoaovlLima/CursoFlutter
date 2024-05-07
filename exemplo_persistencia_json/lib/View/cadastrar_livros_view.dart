import 'dart:io';

import 'package:exemplo_persistencia_json/Controller/livros_controller.dart';
import 'package:exemplo_persistencia_json/Model/livros_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LivroCadastroPage extends StatefulWidget {
  @override
  _LivroCadastroPageState createState() => _LivroCadastroPageState();
}

class _LivroCadastroPageState extends State<LivroCadastroPage> {
  final _formKey = GlobalKey<FormState>();

  LivrosController controller = new LivrosController();
  // Controladores para os campos de texto
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController autorController = TextEditingController();
  final TextEditingController sinopseController = TextEditingController();
  final TextEditingController capaController = TextEditingController();
  final TextEditingController editoraController = TextEditingController();
  final TextEditingController isbnController = TextEditingController();
  final TextEditingController precoController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();

  File? _imagemSelecionada;

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
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
                controller: tituloController,
                decoration: const InputDecoration(
                  labelText: "Título do Livro",
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Título não pode ser Vazio";
                  } else {
                    return null;
                  }
                }),
            TextFormField(
                controller: categoriaController,
                decoration: const InputDecoration(
                  labelText: "Categoria, separe por virgula",
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Categoria não pode ser Vazio";
                  } else {
                    return null;
                  }
                }),

            // ... Outros campos de texto com seus respectivos controladores ...
            //   Wrap(
            //   children: categorias.map((String categoria) {
            //     return CheckboxListTile(
            //       title: Text(categoria),
            //       value: categorias.contains(categoria),
            //       onChanged: (bool? newValue) {
            //         setState(() {
            //           if (newValue == true) {
            //             categorias.add(categoria);
            //           } else {
            //             categorias.remove(categoria);
            //           }
            //         });
            //       },
            //     );
            //   }).toList(),
            // ),
            TextFormField(
                controller: autorController,
                decoration: const InputDecoration(
                  labelText: "Autor",
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Autor não pode ser Vazio";
                  } else {
                    return null;
                  }
                }),
            TextFormField(
                controller: sinopseController,
                decoration: const InputDecoration(
                  labelText: "Sinopse",
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Sinopse não pode ser Vazio";
                  } else {
                    return null;
                  }
                }),
            TextFormField(
                controller: editoraController,
                decoration: const InputDecoration(
                  labelText: "Editora",
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Editora não pode ser Vazio";
                  } else {
                    return null;
                  }
                }),
            TextFormField(
                controller: isbnController,
                decoration: const InputDecoration(
                  labelText: "ISBN",
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "ISBN não pode ser Vazio";
                  } else {
                    return null;
                  }
                }),
            TextFormField(
                controller: precoController,
                decoration: const InputDecoration(
                  labelText: "Preço",
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Preço não pode ser Vazio";
                  } else {
                    return null;
                  }
                }),
  
            _imagemSelecionada != null
                ? Image.file(
                    _imagemSelecionada!,
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  )
                : const SizedBox.shrink(),
            ElevatedButton(
              onPressed: _tirarFoto,
              child: Text('Tirar Foto Capa do Livro'),
            ),
            // ... Restante dos campos de texto ...
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
  
Future<void> _tirarFoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imagemSelecionada = File(pickedFile.path);
      });
    }
  }

  _cadastrarLivro() {
    final livro = Livros(
      id: controller.listLivros.length+1,
    titulo: tituloController.text,
    autor: autorController.text,
    sinopse: sinopseController.text,
    editora: editoraController.text,
    isbn: isbnController.text,
    preco: double.parse(precoController.text),
    categoria: categoriaController.text.split(','),
    capa: _imagemSelecionada!.path,
    );
    controller.addLivro(livro);
    controller.salvarJson();
    _cleanControllers();

    //snackbar
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
    _imagemSelecionada = null;
  
}
}
