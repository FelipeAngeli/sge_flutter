import 'api_exception.dart';

class NotFoundException extends ApiException {
  NotFoundException([super.message = 'Recurso não encontrado']);
}
