import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sge_flutter/models/cliente_model.dart';
import 'cliente_state.dart';

class ClienteCubit extends Cubit<ClienteState> {
  final _box = Hive.box<ClienteModel>('clientes');

  ClienteCubit() : super(ClienteInitial());

  Future<void> carregarClientes() async {
    emit(ClienteLoading());
    try {
      final clientes = _box.values.toList();
      emit(ClienteLoaded(clientes));
    } catch (e) {
      emit(ClienteFailure('Erro ao carregar clientes: $e'));
    }
  }

  Future<void> adicionarCliente(ClienteModel cliente) async {
    await _box.put(cliente.id, cliente);
    carregarClientes();
  }

  Future<void> atualizarCliente(ClienteModel cliente) async {
    await _box.put(cliente.id, cliente);
    carregarClientes();
  }

  Future<void> excluirCliente(String id) async {
    try {
      await _box.delete(id);
      carregarClientes();
    } catch (e) {
      emit(ClienteFailure('Erro ao excluir cliente: $e'));
    }
  }
}
