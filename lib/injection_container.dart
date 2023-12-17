import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:get_it/get_it.dart";
import "package:insta_clone/features/data/data_source/remote_data_sources/remote_data_sources.dart";
import "package:insta_clone/features/data/data_source/remote_data_sources/remote_data_sources_impl.dart";
import "package:insta_clone/features/data/repository/firebase_repository_impl.dart";
import "package:insta_clone/features/domain/respository/firebase_respository.dart";
import "package:insta_clone/features/domain/usecases/firebase_usecases/user/create_user_usecases.dart";
import "package:insta_clone/features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart";
import "package:insta_clone/features/domain/usecases/firebase_usecases/user/get_single_user_usecase.dart";
import "package:insta_clone/features/domain/usecases/firebase_usecases/user/get_user_usecases.dart";
import "package:insta_clone/features/domain/usecases/firebase_usecases/user/is_log_in_usercase.dart";
import "package:insta_clone/features/domain/usecases/firebase_usecases/user/is_log_out_usercases.dart";
import "package:insta_clone/features/domain/usecases/firebase_usecases/user/sign_in_usecase.dart";
import "package:insta_clone/features/domain/usecases/firebase_usecases/user/sign_up_usercases.dart";
import "package:insta_clone/features/domain/usecases/firebase_usecases/user/update_user_usecases.dart";
import "package:insta_clone/features/presentation/bloc/auth/bloc/auth_bloc.dart";
import "package:insta_clone/features/presentation/bloc/credentails/bloc/credentials_bloc.dart";
import "package:insta_clone/features/presentation/bloc/user/get_single_user/bloc/get_single_user_bloc.dart";
import "package:insta_clone/features/presentation/bloc/user/user_bloc/user_bloc.dart";

final sl = GetIt.instance;
Future<void> init() async {
  //Bloc
  sl.registerFactory(
    () => AuthBloc(
      isLogInUseCase: sl.call(),
      isLogOutUseCase: sl.call(),
      getCurrentUidUsecase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => CredentialsBloc(
      signInUseCase: sl.call(),
      signUpUseCase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => UserBloc(
      getUserUseCases: sl.call(),
      getUpdateUserUseCase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => GetSingleUserBloc(
      getSingleUserUseCase: sl.call(),
    ),
  );

  //UseCases
  sl.registerLazySingleton(
    () => IsLogInUseCases(
      repository: sl.call(),
    ),
  );
  sl.registerLazySingleton(
    () => IsLogOutUseCase(
      repository: sl.call(),
    ),
  );
  sl.registerLazySingleton(
    () => GetCurrentUidUsecase(
      repository: sl.call(),
    ),
  );
  sl.registerLazySingleton(
    () => SignInUseCase(
      repository: sl.call(),
    ),
  );
  sl.registerLazySingleton(
    () => SignUpUseCase(
      repository: sl.call(),
    ),
  );
  sl.registerLazySingleton(
    () => GetUserUseCases(
      repository: sl.call(),
    ),
  );
  sl.registerLazySingleton(
    () => GetUpdateUserUseCase(
      repository: sl.call(),
    ),
  );
  sl.registerLazySingleton(
    () => GetSingleUserUseCase(
      repository: sl.call(),
    ),
  );
  sl.registerLazySingleton(
    () => CreateUserUseCases(
      repository: sl.call(),
    ),
  );

  //Repository
  sl.registerLazySingleton<FireBaseRepository>(
    () => FirebaseRepositoryImpl(
      remoteDataSources: sl.call(),
    ),
  );
  //Remote Data Sources
  sl.registerLazySingleton<FirebaseRemoteDataSource>(
    () => FirebaseRemoteDataSourceImpl(
      firebaseFirestore: sl.call(),
      firebaseAuth: sl.call(),
      firebaseStorage: sl.call(),
    ),
  );

  //Externals
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;
  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseStorage);
}
