import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:new_package_intro/common/app_env.dart';
import 'package:new_package_intro/user.dart';

part 'auth_cubit_state.dart';

class AuthCubitCubit extends Cubit<AuthCubitState> {
  AuthCubitCubit(this.dio) : super(InitialState());

  final Dio dio;

  Future<void> signUp(User user) async {
    try {
      var response = await dio.put(AppEnv.auth, data: user.toJson());

      var responseUser = User.fromJson(response.data['data']);

      if(response.statusCode == 200){
        if(responseUser.token == null){
            throw DioError(error: 'Токен невалиден', requestOptions: RequestOptions(path: ''));
        }

        print("1");

        emit(SuccessState(responseUser));
      } else {
        throw DioError(error: 'Произошла ошибка', requestOptions: RequestOptions(path: ''));
      }
    }on DioError catch (e) {
      if(e.message == "Http status error [500]"){
        emit(ErrorState('Неверный логин/пароль'));
      } else {
        emit(ErrorState(e.message));
      }
    }
  }

  Future<void> signIn(User user) async {
    try {
      var response = await dio.post(AppEnv.auth, data: user.toJson());

      var responseUser = User.fromJson(response.data['data']);

      if(response.statusCode == 200){
        if(responseUser.token == null){
            throw DioError(error: 'Токен невалиден', requestOptions: RequestOptions(path: ''));
        }

        emit(SuccessState(responseUser));
      } else {
        throw DioError(error: 'Произошла ошибка', requestOptions: RequestOptions(path: ''));
      }
      
    }on DioError catch (e) {
      if(e.message == "Http status error [500]"){
        emit(ErrorState('Неверный логин/пароль'));
      } else {
        emit(ErrorState(e.message));
      }
    }
  }

  Future<void> logOut() async {emit(InitialState());}
}
