// lib/modules/caixa/cubit/caixa_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sge_flutter/models/movimento_caixa_model.dart';
import 'package:sge_flutter/models/produto_model.dart';
import 'caixa_state.dart';

class CaixaCubit extends Cubit<CaixaState> {
  final Box<ProdutoModel> _produtoBox = Hive.box<ProdutoModel>('produtos');
  final Box<MovimentoCaixaModel> _movimentoBox =
      Hive.box<MovimentoCaixaModel>('movimentos');

  CaixaCubit() : super(CaixaInitial());

  Future<void> loadDashboard() async {
    emit(CaixaLoading());
    try {
      final produtos = _produtoBox.values.toList();
      final movimentacoes = _movimentoBox.values.toList();

      final totalEstoque = produtos.fold<double>(0.0, (sum, produto) {
        return sum + (produto.preco * produto.estoque);
      });

      final now = DateTime.now();
      final seteDiasAtras = now.subtract(const Duration(days: 7));

      final movimentacoesRecentes = movimentacoes
          .where((mov) => mov.data.isAfter(seteDiasAtras))
          .toList();

      final totalEntradas = movimentacoesRecentes
          .where((mov) => mov.tipo == 'entrada')
          .fold<double>(0.0, (sum, mov) => sum + mov.valor);

      final totalSaidas = movimentacoesRecentes
          .where((mov) => mov.tipo == 'saida')
          .fold<double>(0.0, (sum, mov) => sum + mov.valor);

      emit(CaixaLoaded(
        totalEstoque: totalEstoque,
        totalEntradas: totalEntradas,
        totalSaidas: totalSaidas,
        movimentacoesRecentes: movimentacoesRecentes,
      ));
    } catch (e) {
      emit(CaixaError('Erro ao carregar informações do caixa.'));
    }
  }
}
