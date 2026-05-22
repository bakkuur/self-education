import 'package:smart/domain/repositories/user_repository.dart';
import 'package:smart/domain/models/user.dart';

class SaveUserProfileUseCase {
  final UserRepository repository;

  SaveUserProfileUseCase(this.repository);

  Future<void> execute(User user) async {
    await repository.saveUser(user);
  }
}