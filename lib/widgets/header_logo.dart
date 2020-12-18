import 'package:flutter/material.dart';

class HeaderLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
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
}