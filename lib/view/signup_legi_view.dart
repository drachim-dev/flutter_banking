import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_banking/auto_router.gr.dart';
import 'package:flutter_banking/common/colors.dart';
import 'package:flutter_banking/view/signup_form.dart';
import 'package:flutter_banking/widgets/action_button.dart';
import 'package:flutter_banking/widgets/signup_title.dart';

class SignUpLegitimationView extends StatelessWidget {
  static const String identCode = 'KTGA17';
  final String title;

  SignUpLegitimationView({this.title});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
        body: _buildBody(context, theme),
        floatingActionButton: _buildFAB(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  _buildBody(BuildContext context, ThemeData theme) {
    return SignUpFormListView(
      children: [
        SignUpTitle(title: title),
        Icon(
          Icons.contact_phone,
          size: 156,
          color: MyColor.lightGrey,
        ),
        SizedBox(
          height: 36,
        ),
        Text(
          "ID Code",
          textAlign: TextAlign.center,
          style: theme.textTheme.headline3,
        ),
        FlatButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: identCode));
              final snackBar = SnackBar(
                content: Text('Copied to clipboard'),
                duration: Duration(milliseconds: 4000),
                behavior: SnackBarBehavior.floating,
              );
              Scaffold.of(context).showSnackBar(snackBar);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  identCode,
                  style: theme.textTheme.headline1,
                ),
                SizedBox(width: 16),
                Icon(Icons.content_copy, size: 36, color: MyColor.grey)
              ],
            )),
      ],
    );
  }

  ButtomActionButtonBar _buildFAB(final BuildContext context) {
    return ButtomActionButtonBar(
      primary: PrimaryActionButton(
        label: "Identify now",
        onPressed: () {},
      ),
      secondary: SecondaryActionButton(
        label: "Later",
        onPressed: () => navigateToHome(context),
      ),
    );
  }

  void navigateToHome(final BuildContext context) {
    ExtendedNavigator.of(context)
        .pushAndRemoveUntil(Routes.homeView, (_) => false);
  }
}
