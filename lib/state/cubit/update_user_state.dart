part of 'update_user_cubit.dart';

abstract class UpdateUserState{
  const UpdateUserState();
}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserSuccess extends UpdateUserState {}

class UpdateUserError extends UpdateUserState {
  final String message;

  UpdateUserError(this.message);
}