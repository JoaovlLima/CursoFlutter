class Produtos {

  final String nome;
  final int preco;
  final String categoria;
  final String foto;

 const Produtos({
   required this.nome, required this.preco, required this.categoria,
 required this.foto});

  Map<String, dynamic> toJson(){
    return {
      'nome': nome,
      'preco': preco,
      'categoria': categoria,
      'foto': foto
    };
  }
  factory Produtos.fromJson(Map<String, dynamic> json){
    return Produtos(
      nome: json['nome'],
      preco: json['preco'],
      categoria: json['categoria'],
      foto: json['foto']
    );
  }
  
}