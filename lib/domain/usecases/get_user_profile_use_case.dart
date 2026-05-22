import 'package:smart/domain/repositories/user_repository.dart';
import 'package:smart/domain/models/user.dart';

class GetUserProfileUseCase {
  final UserRepository repository;

  GetUserProfileUseCase(this.repository);

  User execute() => repository.getCurrentUser();

  Stream<User> watch() => repository.watchUser();
}