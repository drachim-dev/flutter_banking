import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_banking/common/colors.dart';

class TransparentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  TransparentAppBar(
      {Text title, List<IconButton> actions})
      : appBar = AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: title,
          actions: actions,
        );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: MyColor.transparentStatusBarColor,
        ),
      child: Theme(
        child: appBar,
        data: ThemeData(
          appBarTheme: AppBarTheme(
            brightness: theme.brightness,
            textTheme: theme.textTheme,
            iconTheme: theme.iconTheme,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => appBar.preferredSize;
}
