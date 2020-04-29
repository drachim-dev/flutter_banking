import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/locator.dart';
import 'package:flutter_banking/services/authentication_service.dart';
import 'package:flutter_banking/viewmodel/base_model.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _authService = locator<AuthenticationService>();

  String errorMessage;

  Future<bool> authenticateWithPassword(String password) async {
    setState(ViewState.Busy);
    var success = true;
    setState(ViewState.Idle);

    return success;
  }

  Future<bool> canCheckBiometrics() async {
    setState(ViewState.Busy);
    var success =_authService.canCheckBiometrics();
    setState(ViewState.Idle);

    return success;
  }

  Future<bool> authenticateWithBiometrics() {
    setState(ViewState.Busy);
    var success = _authService.authenticateWithBiometrics('Please authenticate');
    setState(ViewState.Idle);

    return success;
  }

}