import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 400),
        height: 50,
        color: color.color,
        backgroundColor: Colors.white,
       
        index: paginaAtual,
        onTap: (pagina){
          pc.animateToPage(pagina, duration: const Duration(milliseconds: 400), curve: Curves.ease);
        },
        
        items: const [
           Icon(Icons.list, color: Colors.white,),
          Icon(Icons.star_rate, color: Colors.white,),
      ],
      ),
    );
  }
}