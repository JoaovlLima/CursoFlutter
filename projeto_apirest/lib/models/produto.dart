class Produto{
  final int id;
  final String nome;
  final double preco;

  Produto({required this.id, required this.nome, required this.preco});

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
      id: json['id'],
      nome: json['nome'],
      preco: json['preco'],
    );
  }



}
