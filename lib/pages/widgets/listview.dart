import 'package:flutter/material.dart';
import 'package:meu_novo_app/models/moeda.dart';
import 'package:meu_novo_app/repositories/favoritas_repository.dart';
import 'package:meu_novo_app/repositories/moedas_repository.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class ListMoeda extends StatefulWidget{
  final bool listUnSelect;
  final Color color;
  final Function(List<Moedas>) onSelectionChanged;
  const ListMoeda({super.key, required this.color, required this.onSelectionChanged, required this.listUnSelect, required this.moedasDetalhes});
  final Function(Moedas) moedasDetalhes;
  @override
  State<ListMoeda> createState() => _ListMoedaState();
}
class _ListMoedaState extends State<ListMoeda>{
  NumberFormat real = NumberFormat.currency(locale: 'pt-_BR', name: 'R\$');
  List<Moedas> selecionadas=[];
  late FavoritasRepository favoritas;
  late MoedaRepository tabela;

  selectMoeda(List<Moedas> tabela, int moeda){
    setState(() {
                 (selecionadas.contains(tabela[moeda])) ? selecionadas.remove(tabela[moeda]) : selecionadas.add(tabela[moeda]);
              });
  }

  @override
  Widget build(BuildContext context){
    favoritas = context.watch<FavoritasRepository>();
    tabela = context.watch<MoedaRepository>();
    if (widget.listUnSelect){
      selecionadas = [];
    }
    return  ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: MoedaRepository.tabela.length,
      itemBuilder: (BuildContext context, int moeda){
          return ListTile(
            contentPadding: const EdgeInsets.all(8),
            tileColor:  Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(12)),
            leading: (selecionadas.contains(MoedaRepository.tabela[moeda])) 
            ?_buildIconeSelect()
            :SizedBox(
              width: 50, 
              child: Image.asset(MoedaRepository.tabela[moeda].getIcone(), 
                filterQuality: FilterQuality.low,
              ),
              ),
            title: Row( children:[ Text(
              MoedaRepository.tabela[moeda].getNome(), 
              style: const TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
                ),
              
                ), if (favoritas.lista.contains(MoedaRepository.tabela[moeda]))  Icon(Icons.star_rate_rounded, color: Colors.green[400],)]),
            trailing: Text(
              real.format(MoedaRepository.tabela[moeda].getPreco().toDouble()), 
              style:  TextStyle(fontSize: 20, 
              fontWeight: FontWeight.bold,
               decorationColor: widget.color.withOpacity(0.1),
               color: Colors.black54,
               ),
               ),
            selected: selecionadas.contains(MoedaRepository.tabela[moeda]),//(selecionadas.contains(tabela.tabela[moeda])),
            selectedTileColor: widget.color.withOpacity(0.3),
            onLongPress: ()  {
                selectMoeda(MoedaRepository.tabela, moeda);
                widget.onSelectionChanged(selecionadas);
              },
              onTap:() => (selecionadas.isEmpty)? widget.moedasDetalhes(MoedaRepository.tabela[moeda]): (selectMoeda(MoedaRepository.tabela, moeda)),
          );
        
       }, 
       separatorBuilder: (BuildContext context, moeda) =>  const Divider(),
      );
  }
  Widget _buildIconeSelect(){
    return SizedBox(
      width: 50,
      child: CircleAvatar(
        backgroundColor: widget.color, 
        maxRadius: 25,
        child: const Icon(Icons.check, 
        color: Colors.white,
        ),
      ), 
    );
  }
} 
