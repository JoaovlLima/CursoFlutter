import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import '../Model/livros_model.dart';

class LivrosController {
  List<Livros> listLivros = [];

  List<Livros> get ListLivros {
    return listLivros;
  }

  void addLivro(Livros livro) {
    listLivros.add(livro);
  }

  Future<void> salvarJson() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String path = appDocDir.path;
      File file = File('$path/livros.json');
      String json = jsonEncode(listLivros.map((livro) => livro.toJson()).toList());
      await file.writeAsString(json);
      print("Dados salvos no JSON.");
    } catch (e) {
      print("Erro ao salvar o JSON: $e");
    }
  }

  Future<void> carregarJson() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String path = appDocDir.path;
      File file = File('$path/livros.json');
      if (await file.exists()) {
        String json = await file.readAsString();
        List<dynamic> jsonData = jsonDecode(json);
        listLivros = jsonData.map((data) => Livros.fromJson(data)).toList();
        print("Dados carregados do JSON.");
      } else {
        print("Arquivo JSON não encontrado.");
      }
    } catch (e) {
      print("Erro ao carregar o JSON: $e");
    }
  }
}
