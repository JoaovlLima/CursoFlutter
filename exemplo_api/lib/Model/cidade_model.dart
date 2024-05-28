class Cidade{
  final String nomeCidade;
  final bool cidadesFavorita;


  Cidade({
    required this.nomeCidade,
    required this.cidadesFavorita,
  });

  // métodos
  // toMap


  Map<String, dynamic> toMap() {
    return{
      'nomecidade': nomeCidade,
      'cidadesfavorita': cidadesFavorita,
    };
  }
  //FromMap
  factory Cidade.fromMap(Map<String, dynamic> map) {
    return Cidade(
      nomeCidade: map['nomecidade'],
      cidadesFavorita: map['cidadesfavorita'],
    );
  }
}