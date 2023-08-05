import 'package:flutter/material.dart';
import 'package:meu_novo_app/models/moeda.dart';
import 'package:meu_novo_app/repositories/color_repository.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../repositories/favoritas_repository.dart';

class FavoritasPage extends StatefulWidget {
 
  const FavoritasPage({super.key});

  @override
  State<FavoritasPage> createState() => _FavoritasPageState();
}

class _FavoritasPageState extends State<FavoritasPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt-_BR', name: 'R\$');
  List<Moedas> listRemovidas=[];
  late FavoritasRepository favoritas;
  late ColorRepository cor;
  @override
  Widget build(BuildContext context) {
    favoritas = context.watch<FavoritasRepository>();
    cor = context.watch<ColorRepository>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moedas Favoritas'),
        centerTitle: true,
        backgroundColor: cor.color,
      ),
    body:(favoritas.lista.isNotEmpty) ? ListView.separated(
      itemCount: favoritas.lista.length,
      itemBuilder:(context, moeda) {
        return  ListTile(
            contentPadding: const EdgeInsets.all(8),
            tileColor:  Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(12)
              ),
            leading: SizedBox(
              width: 50, 
              child: Image.asset(favoritas.lista[moeda].getIcone(), 
                filterQuality: FilterQuality.low,
              ),
              ),
            title: Text(
              favoritas.lista[moeda].getNome(), 
              style: const TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
                ),
              
                ),
            trailing: Text(
              real.format(favoritas.lista[moeda].getPreco().toDouble()), 
              style:  const TextStyle(fontSize: 20, 
              fontWeight: FontWeight.bold,
               color: Colors.black54,
               ),
               ),
              selected: listRemovidas.contains(favoritas.lista[moeda]),
              selectedTileColor: cor.color.withOpacity(0.3),
              onLongPress: (){
                setState(() {
                 (listRemovidas.contains(favoritas.lista[moeda])) ? listRemovidas.remove(favoritas.lista[moeda]) : listRemovidas.add(favoritas.lista[moeda]);
                    }
                  );
                 },
                 
          );
      },
      separatorBuilder: (context, index) =>   Divider(
        color: cor.color, 
        height: 20,),
    ): const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[Text("não ha moedas ainda", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)]),
      floatingActionButton: (listRemovidas.isNotEmpty) ? FloatingActionButton.extended(
        icon: const Icon(Icons.star_purple500_rounded),
        label:  Text('Remover'.toUpperCase(), style: const TextStyle(letterSpacing: 0, fontWeight: FontWeight.bold)),
        onPressed: (){
        favoritas.remove(listRemovidas);
        setState(() {
          listRemovidas =[];
        });
      },): null,
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
   
    ); 
      
   } 
}