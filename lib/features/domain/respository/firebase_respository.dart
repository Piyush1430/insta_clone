import 'package:insta_clone/features/domain/entities/user/user_entity.dart';

abstract class FireBaseRepository {
  // Credentails Features
  Future<void> signInUser(UserEntity user);
  Future<void> signUpUser(UserEntity user);
  Future<bool> isLogIn();
  Future<void> isLogout();

  // User Features
  Stream<List<UserEntity>> getUsers(UserEntity user);
  Stream<List<UserEntity>> getSingleUsers(String uid);
  Future<String> getCurrentUid();
  Future<void> createUser(UserEntity user);
  Future<void> updateuser(UserEntity user);
}
