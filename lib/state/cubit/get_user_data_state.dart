part of 'get_user_data_cubit.dart';

abstract class GetUserDataState{
  const GetUserDataState();
}

class GUDInitialState extends GetUserDataState {}

class GUDSuccessState extends GetUserDataState {}

class GUDErrorState extends GetUserDataState {
  final String message;

  GUDErrorState(this.message);
}