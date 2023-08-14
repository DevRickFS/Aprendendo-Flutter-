import 'package:flutter/material.dart';
import 'package:meu_novo_app/repositories/moedas_repository.dart';
import 'package:sqflite/sqflite.dart';

import '../database/db.dart';
import '../models/moeda.dart';
import '../models/posicao.dart';


class ContaRepository extends ChangeNotifier{
  late Database db;
  List<Posicao> _carteira = [];
  double _saldo= 0;

  get saldo => _saldo;
  List<Posicao> get carteira => _carteira;
  ContaRepository(){
    _initRepository();
  }

  Future <void> _initRepository() async{
    await _getSaldo();
    await _getCarteira();
  }

  Future <void> _getSaldo() async {
    db = await DB.instance.database;
    List conta = await db.query('conta', limit: 1);
    _saldo = conta.first['saldo'];
    notifyListeners();
  }

  Future <void> setSaldo(double valor) async {
    db = await DB.instance.database;
    db.update('conta', {'saldo': valor});
    _saldo = valor;
    notifyListeners();
  }

  Future comprar(Moedas moeda, double valor) async {
    db = await DB.instance.database;
    await db.transaction((txn) async {
      // verificar se a moeda foi comprada antes
      final posicaoMoeda = await txn
      .query(
        'carteira', 
        where: 'sigla = ?', 
        whereArgs: [moeda.getSigla()],
        );

        if (posicaoMoeda.isEmpty){
          await txn.insert('carteira', {
            'sigla': moeda.getSigla(),
            'moeda': moeda.getNome(),
            'quantidade' : (valor / moeda.getPreco()).toString(),
          });
        } else {
          final atual = double.parse(posicaoMoeda.first['quantidade'].toString());
          await txn.update('carteira', {
            'quantidade': (atual + (valor / moeda.getPreco())).toString()
          }, where: 'sigla = ?', whereArgs: [moeda.getSigla()]);
        }

        // inserir a compra no historico
        await txn.insert('historico', {
            'sigla' : moeda.getSigla(), 
            'moeda': moeda.getNome(),
            'quantidade': (valor / moeda.getPreco()).toString(),
            'valor' : valor,
            'tipo_operacao' : 'compra',
            'data_operacao' : DateTime.now().millisecondsSinceEpoch 
        });

        //atualizar o saldo 
        await txn.update('conta', {'saldo': saldo - valor});

    });

    await _initRepository();
    notifyListeners();
  }

  _getCarteira ()  async {
    _carteira = [];

    List posicoes = await db.query('carteira');
    posicoes.forEach((posicao) {
      Moedas moeda = MoedaRepository.tabela.firstWhere(
        (m) => m.getSigla() == posicao['sigla'],
      );
      _carteira.add(
        Posicao(
          moeda: moeda, 
          quantidade: double.parse(posicao['quantidade']),
        )
      );
    });
    notifyListeners();
  }
}