class Produto {
  //atrbutos
  final String id;
  final String nome;
  final double preco;

  Produto({required this.id, required this.nome, required this.preco});

  //TO JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'preco': preco,
    };
  }
  //FROM JSON
  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: (json['id']).toString(),
      nome: (json['nome']),
      preco: json['preco'] is double ? json['preco'] : double.parse(json['preco'].toString()),
    );
  }

}