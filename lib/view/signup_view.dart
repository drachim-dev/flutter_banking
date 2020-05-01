import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking/common/dimens.dart';
import 'package:flutter_banking/locator.dart';
import 'package:flutter_banking/model/user.dart';
import 'package:flutter_banking/router.gr.dart';
import 'package:flutter_banking/services/authentication_service.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _isLoading = false;
  bool _autoValidate = false;

  String _email, _password, _emailErrorText, _passwordErrorText;

  SignUpViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ChangeNotifierProvider<SignUpViewModel>(
      create: (_) => SignUpViewModel(),
      child: Consumer<SignUpViewModel>(
          builder: (_, SignUpViewModel viewModel, __) {
        this.viewModel = viewModel;

        return Scaffold(
            body: _buildBody(theme),
            floatingActionButton: _buildFAB(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat);
      }),
    );
  }

  _buildBody(ThemeData theme) {
    return ListView(
      padding: const EdgeInsets.only(bottom: Dimens.listScrollPadding),
      children: <Widget>[
        _buildHeader(theme),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.listItemPaddingHorizontal),
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Column(
              children: <Widget>[
                SizedBox(height: Dimens.listItemPaddingVerticalBig),
                _buildTitle(theme),
                SizedBox(height: Dimens.listItemPaddingVerticalBig * 2),
                _buildEmailField(theme),
                SizedBox(height: Dimens.listItemPaddingVertical),
                _buildPasswordField(theme),
                SizedBox(height: Dimens.listItemPaddingVertical),
                FlatButton(
                    onPressed: _onClickCreateAccount,
                    child: Text("I don't have an account yet"))
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onClickCreateAccount() =>
      ExtendedNavigator.rootNavigator.pushNamed(Routes.signUpStepperView);

  Widget _buildHeader(final ThemeData theme) {
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

  TextFormField _buildEmailField(final ThemeData theme) {
    return TextFormField(
      focusNode: _emailFocus,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.next,
      style: theme.textTheme.headline5,
      decoration: InputDecoration(
          labelText: 'E-Mail',
          errorText: _emailErrorText,
          filled: true,
          prefixIcon: Icon(Icons.mail_outline)),
      scrollPadding: const EdgeInsets.only(bottom: Dimens.fabScrollPadding),
      validator: (value) {
        if (!EmailValidator.validate(value)) {
          return 'Email must be valid';
        }

        return null;
      },
      onSaved: (value) => _email = value,
      onFieldSubmitted: (v) => _passwordFocus.requestFocus(),
    );
  }

  TextFormField _buildPasswordField(final ThemeData theme) {
    return TextFormField(
      focusNode: _passwordFocus,
      obscureText: true,
      autocorrect: false,
      enableSuggestions: false,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.done,
      style: theme.textTheme.headline5,
      validator: (value) {
        if (value.isEmpty) {
          return 'Must not be empty';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: 'Password',
          errorText: _passwordErrorText,
          filled: true,
          prefixIcon: Icon(Icons.lock)),
      scrollPadding: const EdgeInsets.only(bottom: Dimens.fabScrollPadding),
      onSaved: (value) => _password = value,
      onFieldSubmitted: (v) => signInWithPassword(),
    );
  }

  Widget _buildFAB() {
    return _isLoading
        ? FloatingActionButton(
            onPressed: null,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ))
        : RaisedButton(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            shape: StadiumBorder(),
            child: Text('Continue'),
            onPressed: () async {
              setState(() => _isLoading = true);
              await signInWithPassword();
              setState(() => _isLoading = false);
            },
          );
  }

  Future<void> signInWithPassword() async {
    final formState = _formKey.currentState;

    // local syntax validation
    if (formState.validate()) {
      
       // save data for login
      formState.save();

      // try to login
      try {
        await viewModel.signInWithPassword(email: _email, password: _password);
        setState(() {
          _emailErrorText = null;
          _passwordErrorText = null;
        });
        ExtendedNavigator.rootNavigator.pushNamed(Routes.homeView);
      } catch (e) {
        switch (e.code) {
          case 'ERROR_USER_NOT_FOUND':
            setState(() {
              _emailErrorText = e.code;
              _passwordErrorText = null;
            });
            break;
          case 'ERROR_WRONG_PASSWORD':
            setState(() {
              _emailErrorText = null;
              _passwordErrorText = e.code;
            });
            break;
          default:
        }
      }
    }
    {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}

class SignUpViewModel with ChangeNotifier {
  final AuthenticationService _authService = locator<AuthenticationService>();
  bool isLoading = false;

  Future<User> _signIn(Future<User> user) async {
    try {
      isLoading = true;
      notifyListeners();
      return await user;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<User> signInWithPassword(
      {@required String email, @required String password}) async {
    try {
      return _signIn(
          _authService.loginWithEmail(email: email, password: password));
    } catch (e) {
      rethrow;
    }
  }
}
