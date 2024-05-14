
class HistoricoClima {
  final int id;
  final String cidade;
  final double temperatura;
  final DateTime dataConsulta;

  HistoricoClima({
    required this.id,
    required this.cidade,
    required this.temperatura,
    required this.dataConsulta,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cidade': cidade,
      'temperatura': temperatura,
      'dataConsulta': dataConsulta.toIso8601String(),
    };
  }
}