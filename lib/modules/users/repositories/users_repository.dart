import '../models/user_model.dart';

class UsersRepository {
  // Dados mockados para testes
  final List<UserModel> _mockUsers = [
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

  Future<List<UserModel>> getUsers() async {
    // Simula delay de rede
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockUsers;
  }

  Future<UserModel?> getUserById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _mockUsers.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<UserModel> createUser(UserModel user) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final newUser =
        user.copyWith(id: DateTime.now().millisecondsSinceEpoch.toString());
    _mockUsers.add(newUser);
    return newUser;
  }

  Future<UserModel> updateUser(UserModel user) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final index = _mockUsers.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _mockUsers[index] = user;
      return user;
    }
    throw Exception('Usuário não encontrado');
  }

  Future<void> deleteUser(String id) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final index = _mockUsers.indexWhere((user) => user.id == id);
    if (index != -1) {
      _mockUsers.removeAt(index);
    } else {
      throw Exception('Usuário não encontrado');
    }
  }

  Future<bool> hasPermission(String userId, String permission) async {
    final user = await getUserById(userId);
    return user?.permissions.contains(permission) ?? false;
  }
}
