import '../../../models/user_model.dart';

abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<UserModel> users;
  UsersLoaded(this.users);
}

class UserLoaded extends UsersState {
  final UserModel user;
  UserLoaded(this.user);
}

class UsersError extends UsersState {
  final String message;
  UsersError(this.message);
}

class UsersValidationError extends UsersState {
  final Map<String, String> errors;
  UsersValidationError(this.errors);
}
