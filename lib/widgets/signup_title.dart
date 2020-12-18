import 'package:flutter/material.dart';
import 'package:flutter_banking/common/dimens.dart';

class SignUpTitle extends StatelessWidget {
  final String title, subtitle, description;

  const SignUpTitle({@required this.title, this.subtitle, this.description});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle = theme.textTheme.headline3;
    final TextStyle subtitleStyle = theme.textTheme.headline6;
    final TextStyle descriptionStyle = theme.textTheme.bodyText2;

    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.listItemPaddingVerticalBig),
      child: Column(
        children: [
          Text(
            title,
            style: titleStyle,
            textAlign: TextAlign.center,
          ),
          if (subtitle != null)
            SizedBox(height: Dimens.listItemPaddingVerticalBig),
          if (subtitle != null)
            Text(
              subtitle,
              style: subtitleStyle,
              textAlign: TextAlign.center,
            ),
          if (description != null)
            SizedBox(height: Dimens.listItemPaddingVerticalBig),
          if (description != null)
            Text(
              description,
              style: descriptionStyle,
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
