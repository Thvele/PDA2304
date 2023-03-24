import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:new_package_intro/common/app_env.dart';
import 'package:new_package_intro/operation.dart';
import 'package:new_package_intro/state/cubit/auth_cubit_cubit.dart';

part 'get_user_data_state.dart';

class GetUserDataCubit extends Cubit<GetUserDataState> {
  GetUserDataCubit(this.dio) : super(GUDInitialState());

  final Dio dio;
  List<dynamic> operations = <dynamic>[];
  int counter = 0;


  Future<void> logOut() async {
    emit(GUDInitialState());
    operations.clear();
  }

  Future<void> getUserOperations(String token, int page, String search) async {

    if(page.isNaN || page.isNegative || page == 0) page = 1;

    try{
      var response = await dio.get(AppEnv.operations, options: Options(headers: {"Authorization": "Bearer $token"}), queryParameters: {"search": search, "page": page});
      try{
        operations = response.data.map((operations) => Operation.fromJson(operations)).toList();
      } catch(e){throw DioError(error: response.data['message'], requestOptions: RequestOptions(path: ''));}

      for(int i = 0; i < operations.length; i++){
        operations[i] = "ID: ${operations[i].operationID}\nНаименование: ${operations[i].operationName}\nОписание: ${operations[i].operationDescription}\nТип: ${operations[i].operationType}\nДата: ${operations[i].operationDate}\nСумма: ${operations[i].operationAmount}";
      }

      counter = operations.length;

      if(response.statusCode == 200){
        emit(GUDSuccessState());
      } else {
        throw DioError(error: 'Произошла ошибка', requestOptions: RequestOptions(path: ''));
      }
    } on DioError catch (e) {
      emit(GUDErrorState(e.message));
    }
  }
}
