import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'caixa_cubit.dart';
import '../../shared/widgets/custom_text_field.dart';
import '../../shared/widgets/custom_button.dart';

class CaixaPage extends StatefulWidget {
  const CaixaPage({super.key});

  @override
  State<CaixaPage> createState() => _CaixaPageState();
}

class _CaixaPageState extends State<CaixaPage> {
  final valorController = TextEditingController();
  final descricaoController = TextEditingController();
  String tipoSelecionado = 'entrada';

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CaixaCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Movimentações de Caixa')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            CustomTextField(
              label: 'Valor',
              controller: valorController,
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              label: 'Descrição',
              controller: descricaoController,
            ),
            DropdownButton<String>(
              value: tipoSelecionado,
              items: const [
                DropdownMenuItem(value: 'entrada', child: Text('Entrada')),
                DropdownMenuItem(value: 'saida', child: Text('Saída')),
              ],
              onChanged: (value) {
                if (value != null) setState(() => tipoSelecionado = value);
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              label: 'Salvar Movimento',
              onPressed: () {
                cubit.adicionarMovimento(
                  valor: double.tryParse(valorController.text) ?? 0.0,
                  tipo: tipoSelecionado,
                  descricao: descricaoController.text,
                );
                valorController.clear();
                descricaoController.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Movimento adicionado!')),
                );
              },
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Text('Movimentações:', style: TextStyle(fontSize: 18)),
            ...cubit.state.map((mov) => ListTile(
                  title: Text('${mov.tipo.toUpperCase()} - R\$${mov.valor}'),
                  subtitle: Text('${mov.descricao} | ${mov.data.toLocal()}'),
                )),
          ],
        ),
      ),
    );
  }
}
