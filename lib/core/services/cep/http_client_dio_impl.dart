import 'package:dio/dio.dart';
import ' i_http_client.dart';
import 'package:sge_flutter/core/exceptions/api_exception.dart';

class HttpClientDioImpl implements IHttpClient {
  final Dio _dio;

  HttpClientDioImpl()
      : _dio = Dio(BaseOptions(
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ));

  @override
  Future<Map<String, dynamic>> get(String url) async {
    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw ApiException('Erro HTTP: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ApiException('Erro Dio: ${e.message}');
    } catch (e) {
      throw ApiException('Erro inesperado: $e');
    }
  }
}
