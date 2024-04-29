import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Model/produtos_model.dart';

class ProdutoInfoPage extends StatelessWidget {
  Produtos produto;
  ProdutoInfoPage({required this.produto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produto Info'),
      ),
      body: Center(
        child: Column(children: [
          Text(produto.nome),
          Text('preco: ${produto.preco}'),
          Text(produto.categoria),
          Image.asset(produto.foto)
        ], 
      )));
  }
}