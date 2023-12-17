import 'package:insta_clone/features/domain/entities/user/user_entity.dart';
import 'package:insta_clone/features/domain/respository/firebase_respository.dart';

class GetSingleUserUseCase {
  final FireBaseRepository repository;

  GetSingleUserUseCase({required this.repository});

  Stream<List<UserEntity>> call(String uid) {
    return repository.getSingleUsers(uid);
  }
}
