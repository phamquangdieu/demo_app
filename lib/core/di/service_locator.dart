import 'package:demo_app/core/network/dio_client.dart';
import 'package:demo_app/features/posts/data/datasource/post_remote_datasource.dart';
import 'package:demo_app/features/posts/data/repositories_impl/post_repository_impl.dart';
import 'package:demo_app/features/posts/domain/repositories/post_repository.dart';
import 'package:demo_app/features/posts/domain/usecases/get_list_post_usecase.dart';
import 'package:demo_app/features/posts/domain/usecases/get_post_by_user_usecase.dart';
import 'package:demo_app/features/posts/presentation/bloc/post_cubit.dart';
import 'package:demo_app/features/users/data/datasources/user_remote_datasource.dart';
import 'package:demo_app/features/users/data/repositories_impl/user_repositories_impl.dart';
import 'package:demo_app/features/users/domain/repositories/user_repository.dart';
import 'package:demo_app/features/users/domain/usecases/get_users_usecase.dart';
import 'package:demo_app/features/users/presentation/bloc/user_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setup() {
  sl.registerLazySingleton(() => DioClient());

  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));

  sl.registerLazySingleton(() => GetUsersUseCase(sl()));

  sl.registerFactory(() => UserCubit(sl()));

  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(sl()));

  sl.registerLazySingleton<GetListPostUsecase>(
    () => GetListPostUsecase(sl<PostRepository>()),
  );
  sl.registerLazySingleton<GetPostByUserUsecase>(
    () => GetPostByUserUsecase(sl<PostRepository>()),
  );

  sl.registerFactory<PostCubit>(
    () => PostCubit(sl<GetListPostUsecase>(), sl<GetPostByUserUsecase>()),
  );
}
