import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:meu_novo_app/repositories/conta_repository.dart';
import 'package:provider/provider.dart';

class ConfigsPage extends StatefulWidget {
  const ConfigsPage({super.key});

  @override
  State<ConfigsPage> createState() => _ConfigsPageState();
}

class _ConfigsPageState extends State<ConfigsPage> {

  @override
  Widget build(BuildContext context) {
    final conta = context.watch<ContaRepository>();
    NumberFormat real = NumberFormat.currency(locale: 'pt-BR', name: 'R\$');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conta'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children:<Widget>[
            ListTile(
              title: const Text('Saldo'),
              subtitle: Text(
                real.format(conta.saldo),
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.indigo,
                ),
              ),
              trailing: IconButton(onPressed: updateSaldo, icon: const Icon(Icons.edit)),
            ),
            const Divider(),
          ]
        ),
        ),
    );
  }
  updateSaldo() async {
    final form = GlobalKey<FormState>();
    final valor = TextEditingController();
    final conta = context.read<ContaRepository>();

    valor.text = conta.saldo.toString();
    AlertDialog dialog = AlertDialog(
      title: Text('Atualizar o saldo'), 
      content: Form(
        key: form,
        child: TextFormField(
          controller: valor,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?d*')),
          ],
          validator: (value) {
            if (value!.isEmpty) return 'Informe o valor do saldo';
            return null;
          },
        ),
        ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text('Cancelar')),
        TextButton(
          onPressed: (){
            if (form.currentState!.validate()){
              conta.setSaldo(double.parse(valor.text));
              Navigator.pop(context);
            }
          }, 
          child: Text('Salvar'))

      ],
    );

    showDialog(context: context, builder: (context) => dialog);
  }
}