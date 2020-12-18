import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificationCode extends StatelessWidget {
  final int itemCount;
  final bool hidden;
  final bool divider;
  final bool autofocus;

  const VerificationCode(
      {@required this.itemCount,
      this.hidden = false,
      this.divider = false,
      this.autofocus = true})
      : assert(itemCount != null && itemCount >= 0);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < (itemCount / 2).floor(); i++)
            _buildItem(context, theme),
          if (divider)
            Text(
              "-",
              style: theme.textTheme.headline1,
            ),
          for (var i = (itemCount / 2).floor(); i < itemCount; i++)
            _buildItem(context, theme),
        ]);
  }

  Widget _buildItem(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      width: 56,
      child: TextField(
        style: theme.textTheme.headline2,
        keyboardType: TextInputType.numberWithOptions(),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textAlign: TextAlign.center,
        autocorrect: false,
        enableSuggestions: false,
        showCursor: false,
        enableInteractiveSelection: false,
        autofocus: true,
        maxLength: 1,
        maxLengthEnforced: true,
        onChanged: (value) {
          value.isEmpty ? FocusScope.of(context).previousFocus() : FocusScope.of(context).nextFocus();
        },
        decoration: InputDecoration(
          filled: true,
          border: UnderlineInputBorder(),
          counterText: "",
        ),
        obscureText: hidden,
      ),
    );
  }
}