import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking/auto_router.gr.dart';
import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/common/colors.dart';
import 'package:flutter_banking/viewmodel/login_model.dart';
import 'package:flutter_banking/view/base_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _controller = TextEditingController();
  bool _canCheckBiometrics = false;
  bool _loginSuccess = false;
  String _errorText;

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(onModelReady: (model) async {
      _canCheckBiometrics = await model.canCheckBiometrics();
      if (_canCheckBiometrics) {
        _loginSuccess = await model.authenticateWithBiometrics();
        if (_loginSuccess) startHome();
      }
    }, builder: (_, model, child) {
      return Stack(children: [
        Scaffold(body: _buildBody(model)),
        _buildBottomColorBar()
      ]);
    });
  }

  Widget _buildBody(LoginModel model) {
    return LayoutBuilder(builder: (_, constraint) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLogo,
              SizedBox(height: 64),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: _buildPasswordField(model),
              ),
              SizedBox(height: 16),
              model.state == ViewState.Busy
                  ? CircularProgressIndicator()
                  : _canCheckBiometrics
                      ? _buildBiometricsButton(model)
                      : SizedBox()
            ],
          ),
        ),
      );
    });
  }

  Align _buildBottomColorBar() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(height: 25, color: MyColor.olbGreen));
  }

  Widget get _buildLogo => Image.asset(
        'assets/images/olb-logo.png',
        scale: 1.25,
      );

  Widget _buildPasswordField(LoginModel model) {
    return TextFormField(
      controller: _controller,
      style: TextStyle(fontSize: 20),
      obscureText: true,
      onEditingComplete: () => _validatePassword(model, _controller.text),
      decoration: InputDecoration(
          filled: true,
          labelText: 'Password',
          hintText: 'Your personal password',
          errorText: _errorText,
          prefixIcon: Icon(Icons.lock),
          contentPadding: const EdgeInsets.all(18),
          suffix: IconButton(
            icon: Icon(Icons.send, color: Theme.of(context).accentColor),
            onPressed: () => _validatePassword(model, _controller.text),
          )),
    );
  }

  Widget _buildBiometricsButton(LoginModel model) {
    return IconButton(
      iconSize: 56.0,
      onPressed: () async {
        _loginSuccess = await model.authenticateWithBiometrics();
        if (_loginSuccess) startHome();
      },
      icon: Icon(Icons.fingerprint, color: MyColor.olbGreen),
    );
  }

  void startHome() {
    ExtendedNavigator.of(context).replace(Routes.homeView);
  }

  void _validatePassword(LoginModel model, String value) async {
    bool didAuthenticate = await model.authenticateWithPassword(value);

    if (didAuthenticate) {
      _errorText = null;
      startHome();
    } else {
      setState(() {
        _errorText = 'Password wrong';
      });
    }
  }
}
