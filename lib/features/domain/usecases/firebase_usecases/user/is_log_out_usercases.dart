import 'package:insta_clone/features/domain/respository/firebase_respository.dart';

class IsLogOutUseCase {
  final FireBaseRepository repository;

  IsLogOutUseCase({required this.repository});

  Future<void> call() {
    return repository.isLogout();
  }
}
