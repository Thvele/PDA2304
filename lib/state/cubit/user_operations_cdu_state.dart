part of 'user_operations_cdu_cubit.dart';

abstract class UserOperationsCduState{
  const UserOperationsCduState();
}

class UOCDUInitialState extends UserOperationsCduState {}

class UOCDUSuccessState extends UserOperationsCduState {}

class UOCDUErrorState extends UserOperationsCduState {
  final String message;

  UOCDUErrorState(this.message);
}