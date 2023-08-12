


import 'package:flutter/material.dart';
import 'package:meu_novo_app/pages/meu_novo_app.dart';
import 'package:meu_novo_app/repositories/color_repository.dart';
import 'package:meu_novo_app/repositories/conta_repository.dart';
import 'package:meu_novo_app/repositories/favoritas_repository.dart';
import 'package:meu_novo_app/repositories/moedas_repository.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FavoritasRepository()
        ), 
        ChangeNotifierProvider(
          create: (context) => ColorRepository()
        ),
        ChangeNotifierProvider(
          create: (context) => MoedaRepository()
        ),
        ChangeNotifierProvider(
          create: (context) => ContaRepository()
        )
        ],
      child: const MeuNovoApp(),) );
}

