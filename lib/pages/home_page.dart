import 'package:flutter/material.dart';
import 'package:meu_novo_app/pages/moedas_page.dart';
import 'package:meu_novo_app/repositories/color_repository.dart';
import 'package:provider/provider.dart';

import 'favoritas_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;
  late ColorRepository color;
  @override
  void initState(){
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  void _setPaginaAtual(pagina){
    setState(() {
      paginaAtual= pagina;
    });
    paginaAtual = pagina;
  }
  

  @override
  Widget build(BuildContext context) {
    color = context.watch<ColorRepository>();
    return Scaffold(
      body: PageView(
        controller: pc,
        onPageChanged: _setPaginaAtual,
        children: const [
          MoedasPage(),
           FavoritasPage(),
      ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        elevation: 2,
        onTap: (pagina){
          pc.animateToPage(pagina, duration: const Duration(milliseconds: 400), curve: Curves.ease);
        },
        
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Moedas', ),
          BottomNavigationBarItem(icon: Icon(Icons.star_rate), label: 'Favoritas')
      ],
      selectedItemColor: color.color,
      ),
    );
  }
}