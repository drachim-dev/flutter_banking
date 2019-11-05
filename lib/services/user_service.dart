import 'dart:async';

import 'package:flutter_banking/model/user.dart';

class UserService {

  Future<User> getUser(int userId) async {
    await Future.delayed(Duration(milliseconds: 500));
    return User(userId, 'Dr. Achim');
  }

}