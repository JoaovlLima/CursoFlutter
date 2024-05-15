class Clima {
  int id;
  int humidAr;
  String pais;
  String nome;
  String descricao;
  double velocVent;
  double temp;
  bool favorito;

  Clima({
    required this.id,
    required this.humidAr,
    required this.descricao,
    required this.nome,
    required this.pais,
    required this.temp,
    required this.velocVent,
    this.favorito = false, 
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'humidAr': humidAr,
      'nome': nome,
      'descricao': descricao,
      'pais': pais,
      'temp': temp,
      'velocVent': velocVent,
      'favorito': favorito,
    };
  }

  factory Clima.fromJson(Map<String, dynamic> json) => Clima(
        id: json["weather"][0]["id"],
        pais: json["sys"]["country"],
        descricao: json["weather"][0]["description"],
        nome: json["name"],
        velocVent: json["wind"]["speed"],
        temp: json["main"]["temp_min"],
        humidAr: json["main"]["humidity"],
        favorito: json['favorito'] ?? false, // Valor padrão se não existir no JSON
      );
}
