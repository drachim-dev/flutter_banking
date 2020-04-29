import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_banking/locator.dart';
import 'package:flutter_banking/model/user.dart';
import 'package:local_auth/local_auth.dart';

class AuthenticationService {
  LocalAuthentication _localAuth = locator<LocalAuthentication>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User> loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return User.fromFirebase(authResult.user);
    } catch(e) {
      rethrow;
    }
  }

  Future<User> signUpWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return User.fromFirebase(authResult.user);
    } catch(e) {
      rethrow;
    }
  }

  Future<bool> canCheckBiometrics() async {
    return _localAuth.canCheckBiometrics;
  }

  Future<bool> authenticateWithBiometrics(String localizedReason) {
    return _localAuth.authenticateWithBiometrics(
        localizedReason: localizedReason);
  }
}
