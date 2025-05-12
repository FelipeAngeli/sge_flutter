import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/user_model.dart';
import '../../../data/repositories/users_repository.dart';
import 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UsersRepository _repository;

  UsersCubit(this._repository) : super(UsersInitial());

  Future<void> loadUsers() async {
    emit(UsersLoading());
    try {
      final users = await _repository.getUsers();
      emit(UsersLoaded(users));
    } catch (e) {
      emit(UsersError(e.toString()));
    }
  }

  Future<void> loadUser(String id) async {
    emit(UsersLoading());
    try {
      final user = await _repository.getUserById(id);
      if (user != null) {
        emit(UserLoaded(user));
      } else {
        emit(UsersError('Usuário não encontrado'));
      }
    } catch (e) {
      emit(UsersError(e.toString()));
    }
  }

  Future<void> createUser(UserModel user) async {
    emit(UsersLoading());
    try {
      final newUser = await _repository.createUser(user);
      emit(UserLoaded(newUser));
    } catch (e) {
      emit(UsersError(e.toString()));
    }
  }

  Future<void> updateUser(UserModel user) async {
    emit(UsersLoading());
    try {
      final updatedUser = await _repository.updateUser(user);
      emit(UserLoaded(updatedUser));
    } catch (e) {
      emit(UsersError(e.toString()));
    }
  }

  Future<void> deleteUser(String id) async {
    emit(UsersLoading());
    try {
      await _repository.deleteUser(id);
      loadUsers();
    } catch (e) {
      emit(UsersError(e.toString()));
    }
  }

  Future<bool> hasPermission(String userId, String permission) async {
    try {
      return await _repository.hasPermission(userId, permission);
    } catch (e) {
      return false;
    }
  }
}
