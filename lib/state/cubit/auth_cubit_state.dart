part of 'auth_cubit_cubit.dart';

abstract class AuthCubitState{
  const AuthCubitState();
}

class InitialState extends AuthCubitState {}

class SuccessState extends AuthCubitState {
  final User user;

  SuccessState(this.user);
}

class ErrorState extends AuthCubitState {
  final String message;

  ErrorState(this.message);
}