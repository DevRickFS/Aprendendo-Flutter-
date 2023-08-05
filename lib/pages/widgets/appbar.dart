import 'package:flutter/material.dart';
import 'package:meu_novo_app/models/moeda.dart';

class MyAppBar extends StatefulWidget{
  final List<Moedas> selecionadas;
  const MyAppBar({super.key, required this.selecionadas});
    @override
  State<MyAppBar> createState() => _MyAppBarState();
  }
  class _MyAppBarState extends State<MyAppBar>{
    @override
  Widget build(BuildContext context){
    return (widget.selecionadas.isEmpty) ? AppBar(
        leading: const Icon(Icons.monetization_on_outlined),
        title: const Text('Cripto Moedas'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () => setState(() {
            debugPrint("Mudando a cor...");
            }), 
            icon: const Icon(Icons.color_lens), 
            iconSize: 36,
            ),
        ],
      ): AppBar(
        title: Text('${widget.selecionadas.length} Selecionadas'),
        centerTitle: true,
      );
   }
  }
