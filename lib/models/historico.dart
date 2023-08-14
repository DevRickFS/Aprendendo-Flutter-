import 'moeda.dart';

class Historico {
  late DateTime dataOperacao;
  late String tipoOoperacao;
  late Moedas moeda;
  late double valor;
  late double quantidade;
  
  Historico({
    required this.dataOperacao,
    required this.tipoOoperacao,
    required this.moeda,
    required this.valor,
    required this.quantidade,
  });

}