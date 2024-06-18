import 'dart:convert';
import '../models/produto.dart';
import 'package:http/http.dart' as http;

class ProdutosController {
  List<Produto> _listProdutos = [];
  
  List<Produto> get listProdutos => _listProdutos;
  
  // getProdutosFromJson http
  Future<List<Produto>> getProdutosFromJson() async {
    final response = await http.get(Uri.parse('http://10.109.204.28:3000/produto'));
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> result = List<Map<String, dynamic>>.from(json.decode(response.body));
      _listProdutos = result.map((prod) => Produto.fromJson(prod)).toList();
      return _listProdutos;
    } else {
      throw Exception('Failed to load Produtos');
    }
  }

  // postProdutosToJson http
  Future<String> postProdutosToJson(Produto produto) async {
    final response = await http.post(
      Uri.parse('http://10.109.204.28:3000/produto'),
      body: json.encode(produto.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Failed to post Produto');
    }
  }

  // deleteProduto http
  Future<void> deleteProduto(String id) async {
    final response = await http.delete(
      Uri.parse('http://10.109.204.28:3000/produto/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      _listProdutos.removeWhere((produto) => produto.id == id);
    } else {
      throw Exception('Failed to delete Produto');
    }
  }

  // updateProduto http
  Future<void> updateProduto(Produto produto) async {
    final response = await http.put(
      Uri.parse('http://10.109.204.28:3000/produto/${produto.id}'),
      body: json.encode(produto.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      int index = _listProdutos.indexWhere((p) => p.id == produto.id);
      if (index != -1) {
        _listProdutos[index] = produto;
      }
    } else {
      throw Exception('Failed to update Produto');
    }
  }
}
