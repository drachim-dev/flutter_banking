import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_banking/common/colors.dart';

class TransparentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final bool hasElevation;

  TransparentAppBar(
      {Widget title, bool centerTitle, this.hasElevation = false, List<IconButton> actions, PreferredSizeWidget bottom})
      : appBar = AppBar(
          backgroundColor: hasElevation ? Colors.white : Colors.transparent,
          elevation: hasElevation ? 2 : 0,
          title: title,
          centerTitle: centerTitle,
          actions: actions,
          bottom: bottom,
        );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: hasElevation ? Colors.transparent : MyColor.transparentStatusBarColor,
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
