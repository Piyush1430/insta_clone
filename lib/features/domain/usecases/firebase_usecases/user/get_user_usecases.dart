import 'package:insta_clone/features/domain/entities/user/user_entity.dart';
import 'package:insta_clone/features/domain/respository/firebase_respository.dart';

class GetUserUseCases {
  final FireBaseRepository repository;

  GetUserUseCases({required this.repository});

  Stream<List<UserEntity>> call(UserEntity user) {
    return repository.getUsers(user);
  }
}
