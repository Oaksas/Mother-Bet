import 'package:mother_bet/dataProvider/auth_data_provider.dart';
import 'package:mother_bet/models/user.dart';

class AuthRepository {
  final AuthDataProvider _dataProvider;

  AuthRepository(this._dataProvider);

  Future<User> login(User user) async {
    return _dataProvider.login(user);
  }

  Future<User> signup(User user) async {
    return _dataProvider.signup(user);
  }

  Future<User> updateProfile(User user, int id) async {
    return _dataProvider.updateProfile(user, id);
  }
}
