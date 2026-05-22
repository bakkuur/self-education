import 'package:smart/domain/models/user.dart';
import 'package:smart/domain/repositories/user_repository.dart';
import 'package:smart/data/datasources/local/shared_prefs_helper.dart';

class UserRepositoryImpl implements UserRepository {
  final SharedPrefsHelper prefs;

  UserRepositoryImpl(this.prefs);

  @override
  User getCurrentUser() {
    return prefs.getUser();
  }

  @override
  Future<void> saveUser(User user) async {
    await prefs.saveUser(user);
  }

  @override
  Future<void> clearUser() async {
    await prefs.clearUser();
  }

  @override
  Stream<User> watchUser() {
    return prefs.watchUser();
  }
}