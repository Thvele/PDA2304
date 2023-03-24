
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:new_package_intro/common/app_env.dart';
import 'package:new_package_intro/state/cubit/auth_cubit_cubit.dart';
import 'package:new_package_intro/state/cubit/get_user_data_cubit.dart';
import 'package:new_package_intro/state/cubit/update_user_cubit.dart';
import 'package:new_package_intro/state/cubit/user_operations_cdu_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => Dio(
    BaseOptions(
      sendTimeout: 1500,
      receiveTimeout: 1500,
      connectTimeout: 1500,
      baseUrl: '${AppEnv.protocol}://${AppEnv.ip}',
    )
  ));

  sl.registerLazySingleton(() => AuthCubitCubit(sl()));
  sl.registerLazySingleton(() => GetUserDataCubit(sl()));
  sl.registerLazySingleton(() => UserOperationsCduCubit(sl()));
  sl.registerLazySingleton(() => UpdateUserCubit(sl()));
}