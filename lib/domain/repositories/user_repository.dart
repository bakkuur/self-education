import 'package:smart/domain/models/user.dart';

abstract class UserRepository {
  User getCurrentUser();
  Future<void> saveUser(User user);
  Future<void> clearUser();
  Stream<User> watchUser();
}