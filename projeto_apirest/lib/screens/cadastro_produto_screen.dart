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

  //future CadatroPRoduto
  Future<void> _cadastrarProduto() async {
    try {
      Produto produto =  Produto(
        id: _idProduto.text, 
        nome: _nomeProduto.text, 
        preco: double.parse(_precoProduto.text));
      await _controller.postProdutosToJson(produto);
    } catch (e) {
      print(e);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Produtos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nomeProduto,
              decoration: InputDecoration(
                labelText: 'Nome do Produto',
              ),
            ),
            TextField(
              controller: _precoProduto,
              decoration: InputDecoration(
                labelText: 'Preço do Produto',
              ),
            ),
            TextField(
              controller: _idProduto,
              decoration: InputDecoration(
                labelText: 'ID do Produto',
              ),
            ),
            ElevatedButton(
              onPressed: _cadastrarProduto,
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}