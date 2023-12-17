
import 'package:insta_clone/features/domain/entities/user/user_entity.dart';
import 'package:insta_clone/features/domain/respository/firebase_respository.dart';

class GetUpdateUserUseCase {
  final FireBaseRepository repository;

  GetUpdateUserUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.updateuser(user);
  }
}
