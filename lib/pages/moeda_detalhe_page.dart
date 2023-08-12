

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();
  late ColorRepository color;
  NumberFormat real = NumberFormat.currency(locale: 'pt-_BR', name: 'R\$');
  double quantidade = 0;

  comprar(){
    if(_form.currentState!.validate()){

      // Salvar em algum banco de dados

      // retornando para pagina anterior
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Compra feita com sucesso!', 
            style: TextStyle(
              color: Colors.black), 
            textAlign: TextAlign.center,), 
            backgroundColor: Colors.white,));
  }
  }

  @override
  Widget build(BuildContext context) {
    color = context.watch<ColorRepository>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.moeda.getNome()),
        centerTitle: true,
        backgroundColor: color.color,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
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
              )
            ),
            (quantidade > 0)?
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 24),
                child: Text(
                  '$quantidade ${widget.moeda.getSigla()}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.teal
                  ),
                ),
              ),
            ): Container(margin:const EdgeInsets.only(bottom: 24)),
            Form(
              key: _form,
              child: TextFormField(
                controller: _valor,
                style: const TextStyle(fontSize: 22),
                decoration:  InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: color.color
                      )
                    ),
                  focusColor: color.color,
                  prefixIconColor: color.color,
                  suffixStyle: 
                    TextStyle(
                        color: color.color
                    ),
                  floatingLabelStyle: 
                    TextStyle(
                      color: color.color
                    ),
                  border: const OutlineInputBorder(), 
                  labelText: 'Valor',
                  prefixIcon: const Icon(Icons.monetization_on_outlined),
                  suffix: const Text(
                    'Reais',
                    style: TextStyle(fontSize: 14) ,
                  )
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, 
                ],
                validator: (value){
                  if (value!.isEmpty){
                    return 'Informe o valor da compra';
                  }else{
                    return null;
                  }
                },
                onChanged: (value){
                  setState(() {
                    quantidade = (value.isNotEmpty) ? double.parse(value) /widget.moeda.getPreco() : 0;
                  });
                },
              ),
            ),
            Container(
              margin:
                const EdgeInsets.only(top: 24),
                alignment: Alignment.center,
                child: 
                ElevatedButton(
                  onPressed: comprar,
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color.color)), 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check, size: 20,), 
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text('Comprar'.toUpperCase()),
                      )
                    ],
                  )
                ),
            )
          ]
        ),
      ),
    );
  }
}