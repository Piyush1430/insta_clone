import 'package:insta_clone/features/domain/respository/firebase_respository.dart';

class GetCurrentUidUsecase {
  final FireBaseRepository repository;

  GetCurrentUidUsecase({required this.repository});
  Future<String> call() {
    return repository.getCurrentUid();
  }
}
