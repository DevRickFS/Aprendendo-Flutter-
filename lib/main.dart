

import 'package:flutter/material.dart';
import 'package:meu_novo_app/pages/meu_novo_app.dart';
import 'package:meu_novo_app/repositories/color_repository.dart';
import 'package:meu_novo_app/repositories/favoritas_repository.dart';
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
          )
        ],
      child: const MeuNovoApp(),) );
}

