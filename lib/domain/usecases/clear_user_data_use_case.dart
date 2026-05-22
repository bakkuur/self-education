import 'package:smart/domain/repositories/user_repository.dart';

class ClearUserDataUseCase {
  final UserRepository repository;

  ClearUserDataUseCase(this.repository);

  Future<void> execute() async {
    await repository.clearUser();
  }
}