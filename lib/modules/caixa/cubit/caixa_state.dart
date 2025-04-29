// lib/modules/caixa/cubit/caixa_state.dart
import 'package:sge_flutter/models/movimento_caixa_model.dart';

abstract class CaixaState {}

class CaixaInitial extends CaixaState {}

class CaixaLoading extends CaixaState {}

class CaixaLoaded extends CaixaState {
  final double totalEstoque;
  final double totalEntradas;
  final double totalSaidas;
  final List<MovimentoCaixaModel> movimentacoesRecentes;

  CaixaLoaded({
    required this.totalEstoque,
    required this.totalEntradas,
    required this.totalSaidas,
    required this.movimentacoesRecentes,
  });
}

class CaixaError extends CaixaState {
  final String message;

  CaixaError(this.message);
}
