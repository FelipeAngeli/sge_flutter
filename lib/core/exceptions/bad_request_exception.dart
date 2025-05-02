import 'api_exception.dart';

class BadRequestException extends ApiException {
  BadRequestException([super.message = 'Requisição inválida']);
}
