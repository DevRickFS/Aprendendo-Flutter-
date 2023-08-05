
import 'package:flutter/material.dart';

import 'home_page.dart';

class MeuNovoApp extends StatelessWidget{ 
  const MeuNovoApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "App Novo de Moedas",
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        primaryColorDark: Colors.deepPurple,
        scaffoldBackgroundColor: const  Color.fromARGB(255, 255, 255, 255),
      ),
      home: const HomePage(),
    );
  }

}
