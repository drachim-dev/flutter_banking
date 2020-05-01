import 'package:flutter/material.dart';
import 'package:flutter_banking/common/colors.dart';
import 'package:flutter_banking/common/dimens.dart';

class ListGroupHeader extends StatelessWidget {
  const ListGroupHeader(
      {Key key,
      @required this.context,
      @required this.leadingText,
      this.trailingText})
      : super(key: key);

  final BuildContext context;
  final String leadingText, trailingText;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final TextStyle textStyle =
        theme.textTheme.subtitle1;
    final Color backgroundColor = isDark ? MyColor.darkGrey : MyColor.transparentPrimary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.listGroupHeaderPaddingVertical),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        color: backgroundColor,
        child: Row(children: <Widget>[
          Expanded(child: Text(leadingText, style: textStyle)),
          if (trailingText != null)
            Text(trailingText, style: textStyle),
        ]),
      ),
    );
  }
}