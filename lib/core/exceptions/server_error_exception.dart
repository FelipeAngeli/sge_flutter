import 'api_exception.dart';

class ServerErrorException extends ApiException {
  ServerErrorException([super.message = 'Erro interno do servidor']);
}
