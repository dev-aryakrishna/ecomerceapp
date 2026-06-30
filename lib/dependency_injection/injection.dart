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
import 'package:dio/dio.dart';
import 'package:ecomerceapp/core/network/dio_client.dart';
import 'package:ecomerceapp/features/products/data/datasource/product_remote_datasource.dart';
import 'package:ecomerceapp/features/products/data/repositories/product_repository_impl.dart';
import 'package:ecomerceapp/features/products/domain/repositories/product_repository.dart';
import 'package:ecomerceapp/features/products/domain/usecases/get_product_usecase.dart';
import 'package:ecomerceapp/features/products/domain/usecases/search_product_usecase.dart';
import 'package:ecomerceapp/features/products/domain/usecases/get_categories_usecase.dart';
import 'package:ecomerceapp/features/products/domain/usecases/get_products_by_categories_usecase.dart';
import 'package:ecomerceapp/features/products/domain/usecases/get_product_detail_usecase.dart';
import 'package:ecomerceapp/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:ecomerceapp/features/products/presentation/bloc/categories/categories_bloc.dart';
import 'package:ecomerceapp/features/products/presentation/bloc/product_detail/product_detail_bloc.dart';
import 'package:ecomerceapp/core/utils/notification_service.dart';
import 'package:ecomerceapp/core/localization/localization_service.dart'; 
import 'package:ecomerceapp/core/themes/theme_service.dart';

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

  
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<Dio>(() => sl<DioClient>().dio);

  sl.registerLazySingleton<ProductRemoteDatasource>(
    () => ProductRemoteDatasourceImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl<ProductRemoteDatasource>()),
  );

  sl.registerLazySingleton(() => GetProductUsecase(sl<ProductRepository>()));
  sl.registerLazySingleton(() => SearchProductUsecase(sl<ProductRepository>()));
  sl.registerLazySingleton(() => GetCategoriesUsecase(sl<ProductRepository>()));
  sl.registerLazySingleton(() => GetProductsByCategoriesUsecase(sl<ProductRepository>()));
  sl.registerLazySingleton(() => GetProductDetailUsecase(sl<ProductRepository>()));

  sl.registerFactory<ProductsBloc>(
    () => ProductsBloc(
      getProductsUsecase: sl<GetProductUsecase>(),
      searchProductsUsecase: sl<SearchProductUsecase>(),
    ),
  );
  sl.registerFactory<CategoriesBloc>(
    () => CategoriesBloc(getCategoriesUsecase: sl<GetCategoriesUsecase>()),
  );
  sl.registerFactory<ProductDetailBloc>(
    () => ProductDetailBloc(
      getProductDetailUsecase: sl<GetProductDetailUsecase>(),
    ),
  );

  sl.registerLazySingleton<NotificationService>(() => NotificationService());

sl.registerLazySingleton<LocalizationService>(
  () => LocalizationService(sl<SharedPreferences>()),
);

sl.registerLazySingleton<ThemeService>(() => ThemeService(sl<SharedPreferences>()));
}