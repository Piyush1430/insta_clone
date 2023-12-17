import 'package:insta_clone/features/data/data_source/remote_data_sources/remote_data_sources.dart';
import 'package:insta_clone/features/domain/entities/user/user_entity.dart';
import 'package:insta_clone/features/domain/respository/firebase_respository.dart';

class FirebaseRepositoryImpl implements FireBaseRepository {
  final FirebaseRemoteDataSource remoteDataSources;

  FirebaseRepositoryImpl({required this.remoteDataSources});
  @override
  Future<void> createUser(UserEntity user) async => remoteDataSources.createUser(user);
  @override
  Future<String> getCurrentUid() async => remoteDataSources.getCurrentUid();


  @override
  Stream<List<UserEntity>> getSingleUsers(String uid) => remoteDataSources.getSingleUsers(uid);
  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) => remoteDataSources.getUsers(user);
  @override
  Future<bool> isLogIn() async => remoteDataSources.isLogIn();
  @override
  Future<void> isLogout() async => remoteDataSources.isLogout();

  @override
  Future<void> signInUser(UserEntity user) async => remoteDataSources.signInUser(user);

  @override
  Future<void> signUpUser(UserEntity user) async => remoteDataSources.signUpUser(user);

  @override
  Future<void> updateuser(UserEntity user) async => remoteDataSources.updateuser(user);
}
