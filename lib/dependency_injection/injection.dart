import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ecomerceapp/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:ecomerceapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ecomerceapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:ecomerceapp/features/auth/domain/usecases/login_usecase.dart';
import 'package:ecomerceapp/features/auth/domain/usecases/signup_usecase.dart';
import 'package:ecomerceapp/features/auth/domain/usecases/logout_usecase.dart';
import 'package:ecomerceapp/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:ecomerceapp/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:ecomerceapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecomerceapp/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:ecomerceapp/features/auth/presentation/bloc/signup/signup_bloc.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  final prefs = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() => prefs);
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
  );

  sl.registerLazySingleton(() => LoginUsecase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SignupUsecase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => LogoutUsecase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => IsLoggedInUsecase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => GetCurrentUserUsecase(sl<AuthRepository>()));

  sl.registerFactory<LoginBloc>(
    () => LoginBloc(loginUseCase: sl<LoginUsecase>()),
  );
  sl.registerFactory<SignupBloc>(
    () => SignupBloc(signUpUseCase: sl<SignupUsecase>()),
  );
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      logoutUseCase: sl<LogoutUsecase>(),
      isLoggedInUseCase: sl<IsLoggedInUsecase>(),
      getCurrentUserUseCase: sl<GetCurrentUserUsecase>(),
    ),
  );
}