import 'dart:async';

import 'package:flutter_banking/locator.dart';
import 'package:flutter_banking/model/user.dart';
import 'package:flutter_banking/services/user_service.dart';
import 'package:local_auth/local_auth.dart';

class AuthenticationService {
  UserService _userService = locator<UserService>();
  LocalAuthentication _localAuth = locator<LocalAuthentication>();

  StreamController<User> _userController = StreamController<User>();
  Stream<User> get user => _userController.stream;

  Future<bool> getUser(int userId) async {
    var fetchedUser = await _userService.getUser(userId);
    var hasUser = fetchedUser != null;

    if(hasUser) {
      _userController.add(fetchedUser);
    }
    return hasUser;
  }

  Future<bool> authenticateWithPassword(String password) async {
    Future.delayed(Duration(milliseconds: 500));
    return password == 'olb';
  }

  Future<bool> canCheckBiometrics() async {
    return _localAuth.canCheckBiometrics;
  }

  Future<bool> authenticateWithBiometrics(String localizedReason) {
    return _localAuth.authenticateWithBiometrics(
        localizedReason: localizedReason);
  }

}