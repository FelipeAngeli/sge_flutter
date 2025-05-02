import '../../../models/movimento_financeiro_model.dart';

abstract class FinanceiroState {}

class FinanceiroInitial extends FinanceiroState {}

class FinanceiroLoading extends FinanceiroState {}

class FinanceiroLoaded extends FinanceiroState {
  final double totalEstoque;
  final double totalEntradas;
  final double totalSaidas;
  final List<MovimentoFinanceiroModel> movimentacoesRecentes;

  FinanceiroLoaded({
    required this.totalEstoque,
    required this.totalEntradas,
    required this.totalSaidas,
    required this.movimentacoesRecentes,
  });
}

class FinanceiroError extends FinanceiroState {
  final String message;

  FinanceiroError(this.message);
}
