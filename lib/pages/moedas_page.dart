


import 'package:flutter/material.dart';
import 'package:meu_novo_app/models/moeda.dart';

import 'package:meu_novo_app/pages/widgets/listview.dart';
import 'package:meu_novo_app/repositories/color_repository.dart';
import 'package:meu_novo_app/repositories/favoritas_repository.dart';
import 'package:meu_novo_app/repositories/moedas_repository.dart';
import 'package:provider/provider.dart';

import 'moeda_detalhe_page.dart';

// Criação de pagina das Moedas
class MoedasPage extends StatefulWidget {
  const MoedasPage({super.key});
  @override
  State<MoedasPage> createState() => _MoedasPageState();
}
  class _MoedasPageState extends State<MoedasPage>{
    late MoedaRepository moedas;
    List<Moedas> selecionadasList=[];
    late FavoritasRepository favoritadas;
    late ColorRepository color;

    _listClean(){
      setState(() {
        selecionadasList = [];
      });
    }
    mostrarDetalhes(Moedas moeda){
      Navigator.push(context, MaterialPageRoute(builder:(_) => MoedaDetalhePage(moeda: moeda,)));
  }
    @override
  Widget build(BuildContext context){
    favoritadas = context.watch<FavoritasRepository>();
    moedas = context.watch<MoedaRepository>();
    color = context.watch<ColorRepository>();
    return Scaffold(
      appBar: (selecionadasList.isEmpty) ? AppBar(
        leading: const Icon(Icons.monetization_on_sharp),
        title: const Text('Cripto Moedas'),
        centerTitle: true,
        backgroundColor: color.color,
        actions: <Widget>[
          IconButton(onPressed: (){ moedas.sort();}, icon: const Icon(Icons.swap_vert_circle_sharp)),
          IconButton(
            onPressed: color.setColor, 
            icon: const Icon(Icons.color_lens), 
            iconSize: 36,
            ),
        ],
      ): AppBar(
        leading: IconButton(
          onPressed:_listClean,
          icon: const Icon(Icons.arrow_back)),
        title: Text('${selecionadasList.length} Selecionadas', style: const TextStyle(color: Colors.black87,)),
        centerTitle: true,
        backgroundColor: Colors.grey[50],
        iconTheme:const IconThemeData(color: Colors.black87),
        elevation: 1,
      ),
    
   
      body:  ListMoeda(
        moedasDetalhes: mostrarDetalhes,
        listUnSelect: selecionadasList.isEmpty,
        color: color.color,
        onSelectionChanged: (updatedList){
          setState(() {
            selecionadasList = updatedList;
          });
        },),
      floatingActionButton: (selecionadasList.isNotEmpty)? 
      FloatingActionButton.extended(
        extendedPadding: const EdgeInsets.all(35),
        icon: const Icon(Icons.star,size: 20,),
        label: const Text('Favoritar',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
        onPressed:(){
          favoritadas.saveAll(selecionadasList);
            _listClean();
           },
        backgroundColor: color.color,
        ): null,
        
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
       } 
           
      }
    

