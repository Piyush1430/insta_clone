import 'package:insta_clone/features/domain/entities/user/user_entity.dart';
import 'package:insta_clone/features/domain/respository/firebase_respository.dart';

class CreateUserUseCases {
  final FireBaseRepository repository;

  CreateUserUseCases({required this.repository});
  Future<void> call(UserEntity user) {
    return repository.createUser(user);
  }
}
