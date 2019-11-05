import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_banking/common/colors.dart';

class TransparentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  TransparentAppBar(
      {Text title, List<IconButton> actions, IconThemeData iconTheme})
      : appBar = AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: title,
          actions: actions,
          iconTheme: iconTheme,
        );

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: MyColor.transparentStatusBarColor,
            statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark
        ),
      child: Theme(
        child: appBar,
        data: ThemeData(
            appBarTheme: AppBarTheme(
                brightness: isDark ? Brightness.light : Brightness.dark),
            brightness: isDark ? Brightness.light : Brightness.dark),
      ),
    );
  }

  @override
  Size get preferredSize => appBar.preferredSize;
}
