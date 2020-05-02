import 'package:flutter/material.dart';

class BiometricAuthNotifier with ChangeNotifier {
  bool _enabled;

  BiometricAuthNotifier(this._enabled);

  bool get enabled => _enabled;

  setEnabled(bool enabled) async {
    _enabled = enabled;
    notifyListeners();
  }
}