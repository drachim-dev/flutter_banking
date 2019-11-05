import 'package:flutter/material.dart';
import 'package:flutter_banking/common/colors.dart';
import 'package:flutter_banking/common/dimensions.dart';

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
    final ThemeData themeData = Theme.of(context);
    final TextStyle groupHeaderTextStyle =
        themeData.textTheme.subhead.copyWith(color: Colors.black);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.listGroupHeaderPaddingVertical),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        color: MyColor.groupHeaderColor,
        child: Row(children: <Widget>[
          Expanded(child: Text(leadingText, style: groupHeaderTextStyle)),
          if (trailingText != null)
            Text(trailingText, style: groupHeaderTextStyle),
        ]),
      ),
    );
  }
}
