class Livros {

  final int id;
  final String titulo;
  final String autor;
  final String sinopse;
  final List<String> categoria;
  final String capa;
  final String editora;
  final String isbn;
  final double preco;

  Livros({required this.id, required this.titulo, required this.autor, required this.sinopse, required this.categoria,
   required this.capa, required this.editora, required this.isbn, required this.preco});

   Map<String,dynamic> toJson(){
    return {
      'id': id,
      'titulo': titulo,
      'autor': autor,
     'sinopse': sinopse,
      'categoria': categoria,
      'capa': capa,
      'editora': editora,
      'isbn': isbn,
      'preco': preco,

   };

}

factory Livros.fromJson(Map<String,dynamic> json){
  return Livros(
    id: json['id'],
    titulo: json['titulo'],
    autor: json['autor'],
    sinopse: json['sinopse'],
    categoria: json['categoria'],
    capa: json['capa'],
    editora: json['editora'],
    isbn: json['isbn'],
    preco: json['preco'],
  );
}
}