import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sge_flutter/core/services/cliente_service.dart';
import 'package:sge_flutter/core/services/cep/cep_service.dart';
import 'package:sge_flutter/models/cliente_model.dart';
import 'cliente_state.dart';

class ClienteCubit extends Cubit<ClienteState> {
  final ClienteService _clienteService;
  final CepService _cepService;

  ClienteCubit(this._clienteService, this._cepService)
      : super(ClienteInitial());

  Future<void> carregarClientes() async {
    emit(ClienteLoading());
    try {
      final clientes = await _clienteService.listarClientes();
      emit(ClienteLoaded(clientes));
    } catch (e) {
      emit(ClienteFailure('Erro ao carregar clientes: $e'));
    }
  }

  Future<void> adicionarCliente(ClienteModel cliente) async {
    await _clienteService.adicionarCliente(cliente);
    carregarClientes();
  }

  Future<void> atualizarCliente(ClienteModel cliente) async {
    await _clienteService.atualizarCliente(cliente);
    carregarClientes();
  }

  Future<void> excluirCliente(String id) async {
    try {
      await _clienteService.excluirCliente(id);
      carregarClientes();
    } catch (e) {
      emit(ClienteFailure('Erro ao excluir cliente: $e'));
    }
  }

  Future<void> buscarCep(String cep) async {
    emit(ClienteCepLoading());
    try {
      final data = await _cepService.buscarCep(cep);
      emit(ClienteCepLoaded(
        endereco: data['logradouro'] ?? '',
        cidade: data['localidade'] ?? '',
        estado: data['uf'] ?? '',
      ));
    } catch (e) {
      emit(ClienteFailure('Erro ao buscar CEP: $e'));
    }
  }
}
