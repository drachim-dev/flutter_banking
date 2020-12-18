import 'package:flutter/material.dart';
import 'package:flutter_banking/common/dimens.dart';

class PrimaryActionButton extends RaisedButton {
  final String label;

  const PrimaryActionButton({
    @required this.label,
    @required VoidCallback onPressed,
  }) : super(onPressed: onPressed);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        shape: StadiumBorder(), child: Text(label), onPressed: onPressed);
  }
}

class SecondaryActionButton extends FlatButton {
  final String label;
  final VoidCallback onPressed;

  const SecondaryActionButton({
    @required this.label,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        shape: StadiumBorder(), child: Text(label), onPressed: onPressed);
  }
}

class ButtomActionButtonBar extends StatelessWidget {
  final Widget primary;
  final Widget secondary;

  const ButtomActionButtonBar({
    @required this.primary,
    this.secondary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimens.primaryActionButtonPaddingHorizontal),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [primary, if (secondary != null) secondary],
      ),
    );
  }
}
