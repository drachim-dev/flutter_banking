import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking/auto_router.gr.dart';
import 'package:flutter_banking/common/dimens.dart';
import 'package:flutter_banking/widgets/action_button.dart';
import 'package:flutter_banking/widgets/header_logo.dart';

class SignUpMobile extends StatefulWidget {
  @override
  _SignUpMobileState createState() => _SignUpMobileState();
}

class _SignUpMobileState extends State<SignUpMobile> {
  final _formKey = GlobalKey<FormState>();
  final List<String> countries = ["+49", "+43", "+56"];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
        body: _buildBody(theme),
        floatingActionButton: _buildFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  _buildBody(ThemeData theme) {
    final TextStyle titleStyle = theme.textTheme.headline3;
    final TextStyle descriptionStyle = theme.textTheme.bodyText2;

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: Dimens.listBigScrollPadding),
      children: [
        HeaderLogo(),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.listItemPaddingHorizontal),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: Dimens.listVerticalPadding),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Signup",
                    style: titleStyle,
                  ),
                  SizedBox(height: Dimens.listItemPaddingVerticalBig),
                  Text(
                    "We will send a verification code to this number",
                    style: descriptionStyle,
                  ),
                  SizedBox(height: Dimens.listItemPaddingVerticalBig * 2),
                  Row(
                    children: [
                      Expanded(flex: 2, child: _buildCountryCode(theme)),
                      SizedBox(width: Dimens.listItemPaddingHorizontal),
                      Expanded(flex: 5, child: _buildMobile(theme)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  DropdownButtonFormField _buildCountryCode(final ThemeData theme) {
    return DropdownButtonFormField(
      decoration: InputDecoration(labelText: 'Country', filled: true),
      items: countries
          .map((country) => DropdownMenuItem(
                child: Text(country),
                value: country,
              ))
          .toList(),
      value: countries.first,
      onChanged: (value) {},
    );
  }

  TextFormField _buildMobile(final ThemeData theme) {
    return TextFormField(
      autofillHints: [AutofillHints.telephoneNumber],
      keyboardType: TextInputType.phone,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.done,
      style: theme.textTheme.headline5,
      scrollPadding: const EdgeInsets.all(Dimens.bigFabScrollPadding),
      validator: (value) {
        if (value.isEmpty) {
          return 'Must not be empty';
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Mobile number', filled: true),
      onFieldSubmitted: (v) => signup(),
    );
  }

  Widget _buildFAB() {
    return ButtomActionButtonBar(
      primary: PrimaryActionButton(
        label: "Continue",
        onPressed: () => signup(),
      ),
      secondary: SecondaryActionButton(
          label: "Can't access your mobile?", onPressed: () => {}),
    );
  }

  signup() => ExtendedNavigator.of(context).push(Routes.signUpStepperView);
}
