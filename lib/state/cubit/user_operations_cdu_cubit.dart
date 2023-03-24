import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:new_package_intro/common/app_env.dart';
import 'package:new_package_intro/operation.dart';
import 'package:new_package_intro/user.dart';

part 'user_operations_cdu_state.dart';

class UserOperationsCduCubit extends Cubit<UserOperationsCduState> {
  UserOperationsCduCubit(this.dio) : super(UOCDUInitialState());

  final Dio dio;

  Future<void> logicalDeleteOperation(User user, int id) async {
    try{
      var response = await dio.post("${AppEnv.operations}/$id", options: Options(headers: {"Authorization": "Bearer ${user.token}"}));

      print(response.statusCode);

      if(response.statusCode == 200){
        emit(UOCDUSuccessState());
      }

    }on DioError catch (e) {
      throw DioError(error: e.message, requestOptions: RequestOptions(path: ''));
    }
  }

  Future<void> deleteOperation(User user, int id) async {
    try{
      var response = await dio.delete("${AppEnv.operations}/$id", options: Options(headers: {"Authorization": "Bearer ${user.token}"}));

      print(response.statusCode);

      if(response.statusCode == 200){
        emit(UOCDUSuccessState());
      }

    }on DioError catch (e) {
      throw DioError(error: e.message, requestOptions: RequestOptions(path: ''));
    }
  }

  Future<void> editOperation(User user, int id, Operation operation) async {
    try{
      var response = await dio.put("${AppEnv.operations}/$id", options: Options(headers: {"Authorization": "Bearer ${user.token}"}), data: operation.toJson());

      print(response.statusCode);

      if(response.statusCode == 200){
        emit(UOCDUSuccessState());
      }

    }on DioError catch (e) {
      throw DioError(error: e.message, requestOptions: RequestOptions(path: ''));
    }
  }

  Future<void> addOperation(User user, Operation operation) async {
    try{
      var response = await dio.post(AppEnv.operations, options: Options(headers: {"Authorization": "Bearer ${user.token}"}), data: operation.toJson());

      print(response.statusCode);

      if(response.statusCode == 200){
        emit(UOCDUSuccessState());
      }

    }on DioError catch (e) {
      throw DioError(error: e.message, requestOptions: RequestOptions(path: ''));
    }
  }
}