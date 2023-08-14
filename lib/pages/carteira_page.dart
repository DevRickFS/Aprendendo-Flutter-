import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meu_novo_app/models/historico.dart';
import 'package:meu_novo_app/repositories/conta_repository.dart';
import 'package:provider/provider.dart';

import '../models/posicao.dart';

class CarteiraPage extends StatefulWidget {
  const CarteiraPage({super.key});

  @override
  State<CarteiraPage> createState() => _CarteiraPageState();
}

class _CarteiraPageState extends State<CarteiraPage> {
  int index = 0;
  double totalCarteira = 0;
  double saldo = 0.0;
  late NumberFormat real;
  late ContaRepository conta;

  String graficoLabel = '';
  double graficoValor = 0;
  List<Posicao> carteira = [];
  @override
  Widget build(BuildContext context) {
    conta = context.watch<ContaRepository>();
    real = NumberFormat.currency(locale:  'pt-BR', name: 'R\$');
    saldo = conta.saldo;

    setTotalCarteira();
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 48, bottom: 8),
              child: Text('Valor da carteira',
                style: TextStyle(
                fontSize: 18
              ),
              ),

            ),
            Text(
              real.format(totalCarteira),
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w700,
                letterSpacing: -1.5,
                ),
              ),
              loadGrafico(),
              loadHistorico(),
          ],
        ),
      ),
    );
  }

  setTotalCarteira(){
    final carteiraList =  conta.carteira;
    setState(() {
      totalCarteira = conta.saldo;
      for (var posicao in carteiraList){
        totalCarteira += posicao.moeda.getPreco() * posicao.quantidade;
      }
    });
  }

  setGraficoDados(int index){
    if (index < 0) return;

    if(index == carteira.length){
      graficoLabel = 'Saldo';
      graficoValor = conta.saldo;
    } else {
      graficoLabel = carteira[index].moeda.getNome();
      graficoValor = carteira[index]. moeda.getPreco() * carteira[index].quantidade;
    }
  }

  loadCarteira(){
    setGraficoDados(index);
    carteira = conta.carteira;
    final tamanhoLista = carteira.length+1;
    return List.generate( tamanhoLista, (i) {
      final isTouched = i == index;
      final isSaldo = i == tamanhoLista - 1;
      final fontSize = isTouched ? 18.0: 14.0;
      final radius = isTouched? 60.0: 50.0;
      final color = isTouched? Colors.tealAccent: Colors.tealAccent[400];
      double porcentagem = 0;
      if (!isSaldo){
        porcentagem = carteira[i].moeda.getPreco() * carteira[i].quantidade/ totalCarteira;
        
      } else {
        porcentagem  = (conta.saldo >= 0)? conta.saldo / totalCarteira: 0;
      }
      porcentagem *= 100;

      return PieChartSectionData(
        color:  color,
        value: porcentagem,
        title: '${porcentagem.toStringAsFixed(0)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black87
        )
      );
    });
  }

  Widget loadGrafico(){
    return (conta.saldo <= 0)? SizedBox(
      width:  MediaQuery.of(context).size.width,
      height: 200,
      child: const Center(
        child: CircularProgressIndicator(

        ),
      ),
    ):Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              sectionsSpace: 5,
              centerSpaceRadius: 110,
              sections: loadCarteira(),
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent touch, PieTouchResponse? response) => setState(() {
                        index = response?.touchedSection?.touchedSectionIndex ?? 0;
                        setGraficoDados(index);
                }),
              )
            )
          ),
        ),
        Column(
          children: [
            Text(graficoLabel,),
            Text(
              real.format(graficoValor),
              style: const TextStyle(fontSize: 24),
            )

          ],
        )
      ],
    );
  }
  loadHistorico(){
    final historico = conta.historico;
    final date = DateFormat('dd/MM/yyyy - HH:mm');
    List<Widget> widgets = [];
    for(var operacao in historico){
      widgets.add(ListTile(
        title: Text('${operacao.moeda.getSigla()} - ${operacao.moeda.getNome()}'),
        subtitle: Text(date.format(operacao.dataOperacao)),
        trailing: Text(real.format((operacao.moeda.getPreco() * operacao.quantidade))),
      )); 
      widgets.add(Divider());
    }
    return Column(
      children: widgets,
    );
  }
}