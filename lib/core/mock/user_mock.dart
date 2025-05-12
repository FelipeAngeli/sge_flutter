import '../../models/user_model.dart';

class UserMock {
  static final List<UserModel> mockUsers = [
    UserModel(
      id: '1',
      name: 'Admin',
      email: 'admin@sge.com',
      cpf: '123.456.789-00',
      phone: '(11) 99999-9999',
      permissions: UserPermissions.admin,
    ),
    UserModel(
      id: '2',
      name: 'Gerente',
      email: 'gerente@sge.com',
      cpf: '987.654.321-00',
      phone: '(11) 98888-8888',
      permissions: UserPermissions.manager,
    ),
    UserModel(
      id: '3',
      name: 'Operador',
      email: 'operador@sge.com',
      cpf: '111.222.333-44',
      phone: '(11) 97777-7777',
      permissions: UserPermissions.operator,
    ),
  ];
}
