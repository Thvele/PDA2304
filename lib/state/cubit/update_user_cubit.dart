import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:new_package_intro/common/app_env.dart';
import 'package:new_package_intro/user.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit(this.dio) : super(UpdateUserInitial());

  final Dio dio;

  Future<void> updateProfile(User user, String token) async {
    try {
      var response = await dio.post(AppEnv.user, data: user.toJson(), options: Options(headers: {"Authorization": "Bearer $token"}));

      var responseUser = User.fromJson(response.data['data']);

      if(response.statusCode == 200){
        emit(UpdateUserSuccess());
        print("1");
      } else {
        throw DioError(error: 'Произошла ошибка', requestOptions: RequestOptions(path: ''));
      }
    }on DioError catch (e) {
      emit(UpdateUserError(e.message));
    }
  }
}
