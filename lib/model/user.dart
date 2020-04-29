import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class User {
  String id;
  String name;

  User({@required this.id, this.name});

  static User fromFirebase(FirebaseUser user) {
    return User(id: user.uid, name: user.displayName);
  }
}