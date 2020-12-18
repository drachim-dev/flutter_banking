import 'package:flutter/material.dart';
import 'package:flutter_banking/common/dimens.dart';

class SignUpFormListView extends StatelessWidget {
  final List<Widget> children;
  final bool scrollable;

  const SignUpFormListView({@required this.children, this.scrollable = true});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: scrollable
          ? ScrollPhysics() // AlwaysScrollableScrollPhysics()
          : NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
          left: Dimens.listItemPaddingHorizontal,
          right: Dimens.listItemPaddingHorizontal,
          top: Dimens.listVerticalPadding,
          bottom: Dimens.listScrollPadding),
      itemBuilder: (BuildContext context, int index) => children[index],
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: Dimens.inputFieldVerticalPadding);
      },
      itemCount: children.length,
    );
  }
}

class SignUpFormField extends StatelessWidget {
  const SignUpFormField(
    this.label, {
    this.controller,
        this.autofillHints,
        this.autocorrect =true,
        this.enableSuggestions = true,
    this.readonly = false,
    this.autofocus = true,
    this.filled = true,
    @required this.focusId,
    this.nextFocusId,
    this.keyboardType,
    this.textCapitalization,
    this.helperText,
    this.onTap,
    this.onFieldSubmitted,
  }) : lastField = nextFocusId == null;

  final String label;
  final TextEditingController controller;
  final Iterable<String> autofillHints;
  final bool autocorrect;
  final bool enableSuggestions;
  final bool readonly;
  final bool autofocus;
  final bool filled;
  final FocusNode focusId;
  final FocusNode nextFocusId;
  final bool lastField;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final String helperText;
  final VoidCallback onTap;
  final VoidCallback onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return TextFormField(
        controller: controller ?? TextEditingController(),
        autofillHints: autofillHints,
        autocorrect: autocorrect,
        enableSuggestions: enableSuggestions,
        readOnly: readonly,
        autofocus: autofocus,
        focusNode: focusId,
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
          filled: filled,
          contentPadding: const EdgeInsets.all(Dimens.textFieldInnerPadding),
        ),
        onFieldSubmitted: (v) =>
            lastField ? onFieldSubmitted() : nextFocusId.requestFocus(),
        onTap: onTap,
        scrollPadding: const EdgeInsets.only(bottom: Dimens.fabScrollPadding));
  }
}
