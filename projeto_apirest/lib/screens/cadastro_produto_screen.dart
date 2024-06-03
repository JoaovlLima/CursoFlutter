import 'package:flutter/material.dart';
import 'package:projeto_apirest/controllers/ProdutoController.dart';
import 'package:projeto_apirest/models/produto.dart';

class CadastroProdutoScreen extends StatefulWidget {
  const CadastroProdutoScreen({super.key});

  @override
  State<CadastroProdutoScreen> createState() => _CadastroProdutoScreenState();
}

class _CadastroProdutoScreenState extends State<CadastroProdutoScreen> {
  final ProdutosController _controller = ProdutosController();
  final TextEditingController _nomeProduto = TextEditingController();
  final TextEditingController _precoProduto = TextEditingController();
  final TextEditingController _idProduto = TextEditingController();

  Future<void> _cadastrarProduto() async{
    try{
      Produto produto = Produto(
        id: id
      , nome: nome,
       preco: preco)
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}