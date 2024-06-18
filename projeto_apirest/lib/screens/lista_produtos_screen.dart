import 'package:flutter/material.dart';
import 'package:projeto_apirest/controllers/ProdutoController.dart';
import '../models/produto.dart';



class ListaProdutosScreen extends StatefulWidget {
  const ListaProdutosScreen({super.key});

  @override
  State<ListaProdutosScreen> createState() => _ListaProdutosScreenState();
}

class _ListaProdutosScreenState extends State<ListaProdutosScreen> {
  final ProdutosController _controller = ProdutosController();

  Future<List<Produto>> futureProdutos() async {
    try {
      return await _controller.getProdutosFromJson();
    } catch (e) {
      print(e);
      return [];
    }
  }

  void deleteProduto(String id) {
    try {
      _controller.deleteProduto(id);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Produto deletado com sucesso.'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao deletar o produto.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void updateProduto(Produto produto) async {
    try {
      await _controller.updateProduto(produto);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Produto atualizado com sucesso.'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao atualizar o produto.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Produtos'),
      ),
      body: FutureBuilder<List<Produto>>(
        future: futureProdutos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Nenhum produto encontrado."));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final produto = snapshot.data![index];
                return ListTile(
                  title: Text(produto.nome),
                  subtitle: Text(produto.preco.toStringAsFixed(2)),
                  trailing: IconButton(
                    icon: Icon(Icons.update),
                    onPressed: () {
                      // Implementar a edição do produto aqui
                      // Por exemplo: Navigator.push para uma tela de edição
                      updateProduto(produto);
                    },
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Confirmar exclusão'),
                        content: Text('Deseja realmente excluir ${produto.nome}?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              deleteProduto(produto.id);
                              Navigator.of(context).pop();
                            },
                            child: Text('Confirmar'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
