import 'package:insta_clone/features/domain/respository/firebase_respository.dart';

class IsLogInUseCases {
  final FireBaseRepository repository;

  IsLogInUseCases({required this.repository});

  Future<bool> call() {
    return repository.isLogIn();
  }
}
