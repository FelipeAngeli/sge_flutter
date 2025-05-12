import 'package:dio/dio.dart';
import '../services/cep/ i_http_client.dart';
import '../exceptions/api_exception.dart';
import '../exceptions/not_found_exception.dart';
import '../exceptions/bad_request_exception.dart';
import '../exceptions/server_error_exception.dart';
import '../exceptions/unauthorized_exception.dart';

class DioHttpClient implements IHttpClient {
  final Dio _dio;

  DioHttpClient(this._dio);

  @override
  Future<Map<String, dynamic>> get(String url) async {
    try {
      final response = await _dio.get(url);
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        switch (e.response?.statusCode) {
          case 400:
            throw BadRequestException();
          case 401:
          case 403:
            throw UnauthorizedException();
          case 404:
            throw NotFoundException();
          case 500:
          default:
            throw ServerErrorException();
        }
      } else {
        throw ApiException('Erro de conexão: ${e.message}');
      }
    }
  }
}
