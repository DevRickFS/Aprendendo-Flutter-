class Moedas{
  String _icone = "";
  String _nome = "";
  String _sigla = "";
  double _preco = 0.0;
  bool select = false;

  Moedas({ required String icone, required String nome, required String sigla, required double preco}){
    _icone = icone;
    _nome = nome;
    _sigla = sigla;
    _preco = preco;
  }

  String getIcone() => _icone;
  String getNome() => _nome;
  String getSigla() => _sigla;
  double getPreco() => _preco;
}