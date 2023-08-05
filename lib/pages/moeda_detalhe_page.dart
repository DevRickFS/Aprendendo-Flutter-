import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meu_novo_app/models/moeda.dart';
import 'package:meu_novo_app/repositories/color_repository.dart';
import 'package:provider/provider.dart';

class MoedaDetalhePage extends StatefulWidget {
  const MoedaDetalhePage({super.key, required this.moeda});
  final Moedas moeda;
  

  @override
  State<MoedaDetalhePage> createState() => _MoedaDetalhePageState();
}

class _MoedaDetalhePageState extends State<MoedaDetalhePage> {
  late ColorRepository color;
  NumberFormat real = NumberFormat.currency(locale: 'pt-_BR', name: 'R\$');
  @override
  Widget build(BuildContext context) {
    color = context.watch<ColorRepository>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.moeda.getNome()),
        centerTitle: true,
        backgroundColor: color.color,
      ),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(24),child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 60,child: Image.asset(widget.moeda.getIcone()),), 
              Container(width: 20,),
              Text(real.format(widget.moeda.getPreco()), 
                style: const TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 24),
                    )
                  ]
                ))
          
              ]
            ),
    );
  }
}