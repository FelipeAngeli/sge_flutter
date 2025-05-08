import '../../core/mock/user_mock.dart';
import '../../models/user_model.dart';

class UsersRepository {
  final List<UserModel> _mockUsers = UserMock.mockUsers;

  Future<List<UserModel>> getUsers() async {
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
