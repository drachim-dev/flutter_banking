import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking/common/dimens.dart';
import 'package:flutter_banking/router.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool _isLoading = false;
  bool _hasAccount = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  String _passwordErrorText;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
        body: _buildBody(theme),
        backgroundColor: Colors.white,
        floatingActionButton: _buildFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  _buildBody(ThemeData theme) {
    return ListView(
      padding: const EdgeInsets.only(bottom: Dimens.listScrollPadding),
      children: <Widget>[
        _buildHeader(theme),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.listItemPaddingHorizontal),
          child: Column(
            children: <Widget>[
              SizedBox(height: Dimens.listItemPaddingVerticalBig),
              _buildTitle(theme),
              SizedBox(height: Dimens.listItemPaddingVerticalBig * 2),
              _buildEmailField(theme),
              SizedBox(height: Dimens.listItemPaddingVertical),
              if (_hasAccount) _buildPasswordField(theme),
            ],
          ),
        ),
      ],
    );
  }

  _buildHeader(final ThemeData theme) {
    final TextStyle headerStyle =
        theme.textTheme.headline1.copyWith(color: Colors.white70);

    return Container(
      alignment: Alignment.topCenter,
      constraints: BoxConstraints.expand(
        height: 260.0,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 72.0),
        child: Text(
          'New Bank',
          style: headerStyle,
        ),
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/login_header.png',
              ),
              fit: BoxFit.fill)),
    );
  }

  Text _buildTitle(final ThemeData theme) {
    final TextStyle titleStyle = theme.textTheme.headline2;

    return Text('Signup', style: titleStyle);
  }

  _buildEmailField(final ThemeData theme) {
    return TextFormField(
      focusNode: _emailFocus,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.next,
      style: theme.textTheme.headline5,
      decoration: InputDecoration(
          labelText: 'E-Mail',
          filled: true,
          prefixIcon: Icon(Icons.mail_outline)),
      scrollPadding: const EdgeInsets.only(bottom: Dimens.fabScrollPadding),
      onFieldSubmitted: (v) => _passwordFocus.requestFocus(),
    );
  }

  _buildPasswordField(final ThemeData theme) {
    return TextFormField(
      focusNode: _passwordFocus,
      controller: _passwordController,
      obscureText: true,
      autocorrect: false,
      enableSuggestions: false,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.done,
      style: theme.textTheme.headline5,
      decoration: InputDecoration(
          labelText: 'Password',
          errorText: _passwordErrorText,
          filled: true,
          prefixIcon: Icon(Icons.lock)),
      scrollPadding: const EdgeInsets.only(bottom: Dimens.fabScrollPadding),
      onFieldSubmitted: (v) => tryLogin(),
    );
  }

  _buildFAB() {
    return _isLoading
        ? FloatingActionButton(
            onPressed: () {},
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ))
        : RaisedButton(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            shape: StadiumBorder(),
            child: Text('Continue'),
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              await Future.delayed(Duration(milliseconds: 500));
              setState(() {
                _isLoading = false;
              });
              if (_emailController.text == 'tim.wiechmann@web.de') {
                if (_hasAccount) {
                  tryLogin();
                } else {
                  setState(() {
                    _hasAccount = true;
                  });
                }
              } else {
                Navigator.of(context).pushNamed(Router.signUpStepperView);
              }
            },
          );
  }

  tryLogin() {
    // check login credentials
    if (_passwordController.text == 'test123') {
      setState(() => _passwordErrorText = null);
      Navigator.of(context).pushNamed(Router.homeView);
    } else {
      setState(() => _passwordErrorText = 'Wrong password');
    }
  }
}
