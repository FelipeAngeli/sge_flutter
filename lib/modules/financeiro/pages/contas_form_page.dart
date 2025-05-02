import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sge_flutter/modules/financeiro/cubit/financeiro_cubit.dart';
import 'package:sge_flutter/models/lancamento_model.dart';
import 'package:uuid/uuid.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import '../../../shared/widgets/currency_text_field.dart';
import '../../../shared/widgets/primary_button.dart';

class ContaFormPage extends StatefulWidget {
  const ContaFormPage({super.key});

  @override
  State<ContaFormPage> createState() => _ContaFormPageState();
}

class _ContaFormPageState extends State<ContaFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  DateTime? _dataSelecionada;
  LancamentoModel? conta;

  String get _dataFormatada {
    if (_dataSelecionada == null) return 'Selecionar Data';
    return '${_dataSelecionada!.day.toString().padLeft(2, '0')}/'
        '${_dataSelecionada!.month.toString().padLeft(2, '0')}/'
        '${_dataSelecionada!.year}';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    conta = Modular.args.data;
    if (conta != null) {
      _descricaoController.text = conta!.descricao;
      _valorController.text = conta!.valor.toStringAsFixed(2);
      _dataSelecionada = conta!.dataVencimento;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FinanceiroCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(conta == null ? 'Nova Conta' : 'Editar Conta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(
                controller: _descricaoController,
                label: 'Descrição',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              CurrencyTextField(
                label: 'Valor (R\$)',
                controller: _valorController,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.calendar_today),
                label: Text(_dataFormatada),
                onPressed: () async {
                  final data = await showDatePicker(
                    context: context,
                    initialDate: _dataSelecionada ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (data != null) {
                    setState(() {
                      _dataSelecionada = data;
                    });
                  }
                },
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                label: 'Salvar',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final novoLancamento = LancamentoModel(
                      id: conta?.id ?? const Uuid().v4(),
                      descricao: _descricaoController.text,
                      valor: double.tryParse(_valorController.text
                              .replaceAll(RegExp(r'[^0-9.]'), '')) ??
                          0.0,
                      dataVencimento: _dataSelecionada ?? DateTime.now(),
                      pago: conta?.pago ?? false,
                    );
                    await cubit.financeiroService
                        .adicionarLancamento(novoLancamento);
                    cubit.loadContas();
                    Modular.to.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
