import 'package:flutter/material.dart';
import 'package:flutter_banking/common/dimens.dart';

class SignUpFormListView extends StatelessWidget {
  final List<Widget> list;

  const SignUpFormListView({@required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(
          left: Dimens.listItemPaddingHorizontal,
          right: Dimens.listItemPaddingHorizontal,
          top: Dimens.listItemPaddingVerticalBig,
          bottom: Dimens.listScrollPadding),
      itemBuilder: (BuildContext context, int index) => list[index],
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: Dimens.inputFieldVerticalPadding);
      },
      itemCount: list.length,
    );
  }
}

class SignUpFormField extends StatelessWidget {
  const SignUpFormField(
    this.label, {
    this.autofocus = true,
    @required this.focusId,
    this.nextFocusId,
    this.keyboardType,
    this.textCapitalization,
    this.helperText,
    this.onFieldSubmitted,
  }) : lastField = nextFocusId == null;

  final String label;
  final bool autofocus;
  final FocusNode focusId;
  final FocusNode nextFocusId;
  final bool lastField;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final String helperText;
  final VoidCallback onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return TextFormField(
        focusNode: focusId,
        autofocus: autofocus,
        keyboardType: keyboardType ?? TextInputType.text,
        textCapitalization: textCapitalization ?? TextCapitalization.words,
        textInputAction:
            lastField ? TextInputAction.done : TextInputAction.next,
        style: theme.textTheme.headline5,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          helperText: helperText,
          labelText: label,
          labelStyle: TextStyle(height: Dimens.inputFieldLabelHeight),
          border: UnderlineInputBorder(),
          filled: true,
          contentPadding: const EdgeInsets.all(Dimens.textFieldInnerPadding),
        ),
        onFieldSubmitted: (v) =>
            lastField ? onFieldSubmitted() : nextFocusId.requestFocus(),
        scrollPadding: const EdgeInsets.only(bottom: Dimens.fabScrollPadding));
  }
}

class ValidationFormField extends StatelessWidget {
  const ValidationFormField(
    this.label, {
    this.autofocus = true,
    @required this.focusId,
    this.nextFocusId,
    this.keyboardType,
    this.onFieldSubmitted,
  }) : lastField = nextFocusId == null;

  final String label;
  final bool autofocus;
  final FocusNode focusId;
  final FocusNode nextFocusId;
  final bool lastField;
  final TextInputType keyboardType;
  final VoidCallback onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return TextFormField(
        focusNode: focusId,
        autofocus: autofocus,
        keyboardType: keyboardType ?? TextInputType.text,
        textCapitalization: TextCapitalization.characters,
        textInputAction:
            lastField ? TextInputAction.done : TextInputAction.next,
        style: theme.textTheme.headline5.copyWith(letterSpacing: 10),
        textAlign: TextAlign.center,
        maxLength: 4,
        maxLengthEnforced: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
              TextStyle(height: Dimens.inputFieldLabelHeight, letterSpacing: 1),
          border: OutlineInputBorder(),
          filled: false,
        ),
        onFieldSubmitted: (v) =>
            lastField ? onFieldSubmitted() : nextFocusId.requestFocus(),
        scrollPadding: const EdgeInsets.only(bottom: Dimens.fabScrollPadding));
  }
}
