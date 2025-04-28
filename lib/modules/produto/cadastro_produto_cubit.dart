// lib/modules/produto/cadastro_produto_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/services/produto_service.dart';
import '../../models/produto_model.dart';
import 'package:uuid/uuid.dart';

class CadastroProdutoCubit extends Cubit<List<ProdutoModel>> {
  final ProdutoService _service;

  CadastroProdutoCubit(this._service) : super([]);

  Future<void> loadProdutos() async {
    final produtos = _service.listarProdutos();
    emit(produtos);
  }

  Future<void> adicionarProduto({
    required String nome,
    required String descricao,
    required double preco,
    required int quantidade,
  }) async {
    final novoProduto = ProdutoModel(
      id: const Uuid().v4(),
      nome: nome,
      descricao: descricao,
      preco: preco,
      quantidade: quantidade,
    );
    await _service.salvarProduto(novoProduto);
    loadProdutos();
  }
}
