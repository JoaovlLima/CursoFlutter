import 'dart:convert';

import 'package:flutter/services.dart';

import '../Model/produtos_model.dart';

class ProdutosController{

  List<Produtos> produtos = [];


  Future<List<Produtos>> loadProdutos() async {
    final data = await rootBundle.loadString('assets/produtos.json');
    final jsonList = json.decode(data) as List<dynamic>;
    produtos.clear();
    produtos.addAll(jsonList.map((e) => Produtos.fromJson(e)));
    
    return produtos;
  }
 
}
