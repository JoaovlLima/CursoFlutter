import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../Model/livros_model.dart';

class LivrosController{
  List<Livros> listLivros = [];
//get
  List<Livros> get ListLivros{
    return listLivros;
  }

  void addLivro (Livros livro){
    listLivros.add(livro);
  }
  //Json - salvar/carregar

  Future<void> salvarJson() async {
    Directory appDocDir = await getApplicationDocumentsDirectory(); 
    String path = appDocDir.path;
    File file = File('$path/livros.json');
    String json = jsonEncode(listLivros);
    await file.writeAsString(json);

  }
  



}