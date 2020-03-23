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
    return TextField(
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        textInputAction: TextInputAction.done,
        style: theme.textTheme.headline5,
        decoration: InputDecoration(
            labelText: 'E-Mail',
            filled: true,
            prefixIcon: Icon(Icons.mail_outline)),
        scrollPadding: const EdgeInsets.only(bottom: Dimens.fabScrollPadding));
  }

  FloatingActionButton _buildFAB() {
    return FloatingActionButton.extended(
      onPressed: () =>
          Navigator.of(context).pushNamed(Router.signUpStepperView),
      label: Text('Continue'),
    );
  }
}
