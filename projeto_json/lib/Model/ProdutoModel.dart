class Produto {
  final int id;
  final String nome;
  final String descricao;
  final int quantidade;
  final String foto;
  final double preco;
  final List<dynamic> categoria;

  Produto({
    required this.id, required this.nome, required this.descricao,
     required this.quantidade, required this.foto, required this.preco,
      required this.categoria
  })

  Map<String, dynamic> toJson() {
    return{
      'id' : id,
      'nome': nome,
      'descricao': descricao,
      'quantidade': quantidade,
      'foto': foto,
      'preco': preco,
      'categoria': categoria
    };
  }

  
}