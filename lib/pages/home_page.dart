import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:meu_novo_app/pages/moedas_page.dart';
import 'package:meu_novo_app/repositories/color_repository.dart';
import 'package:provider/provider.dart';

import 'configs_page.dart';
import 'carteira_page.dart';
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
          CarteiraPage(),
          ConfigsPage(),
      ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration:  const Duration(milliseconds:300),
        color: color.color,
       backgroundColor: Colors.white,
        index: paginaAtual,
        onTap: (pagina){
          pc.animateToPage(pagina, duration: const Duration(milliseconds: 
          300), curve: Curves.easeInOut);
        },
        
        items: const [
          Icon(Icons.list, color: Colors.white,),
          Icon(Icons.star_rate, color: Colors.white,),
          Icon(Icons.account_balance, color:  Colors.white,),
          Icon(Icons.settings, color: Colors.white,)
      ],
      ),
    );
  }
}