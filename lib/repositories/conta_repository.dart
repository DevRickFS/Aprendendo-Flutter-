import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../database/db.dart';
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
}