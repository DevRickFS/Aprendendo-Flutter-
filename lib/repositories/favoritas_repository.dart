import 'dart:collection';

import 'package:flutter/material.dart';

import '../models/moeda.dart';

class FavoritasRepository extends ChangeNotifier{
   List<Moedas> _lista = [];
  UnmodifiableListView<Moedas> get lista => UnmodifiableListView(_lista);

  saveAll(List<Moedas> moedas){
    for (var moeda in moedas) {
      if (! _lista.contains(moeda)){
      _lista.add(moeda);
      }
    }
    notifyListeners();
  }
  remove(List<Moedas> moeda){
    for (var element in moeda) {
      if (_lista.contains(element)){
      _lista.remove(element);
      } 
    }
    notifyListeners();
  }
}