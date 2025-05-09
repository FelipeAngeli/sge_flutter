import 'package:sge_flutter/core/exceptions/api_exception.dart';
import 'package:sge_flutter/core/exceptions/bad_request_exception.dart';
import 'package:sge_flutter/core/services/cep/%20i_http_client.dart';

class CepService {
  final IHttpClient _httpClient;

  CepService(this._httpClient);

  Future<Map<String, dynamic>> buscarCep(String cep) async {
    try {
      final data = await _httpClient.get('https://viacep.com.br/ws/$cep/json/');

      if (data['erro'] == true) {
        throw BadRequestException('CEP não encontrado.');
      }

      return data;
    } on BadRequestException {
      rethrow;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Erro inesperado ao buscar CEP: $e');
    }
  }
}
