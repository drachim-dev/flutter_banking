import 'package:flutter/material.dart';
import 'package:flutter_banking/view/signup_form.dart';

class SignUpTaxView extends StatelessWidget {
  final FocusNode _taxId = FocusNode();
  final FocusNode _codeFocus = FocusNode();

  final VoidCallback nextPage;

  SignUpTaxView({this.nextPage});

  @override
  Widget build(BuildContext context) {
    return SignUpFormListView(
      list: [
        SignUpFormField('Tax ID (optional)',
            keyboardType: TextInputType.number,
            textCapitalization: TextCapitalization.words,
            helperText: "If you don't know your tax id, we will determine it automatically",
            focusId: _taxId,
            nextFocusId: _codeFocus),
        SignUpFormField('Placeholder field',
            keyboardType: TextInputType.number,
            textCapitalization: TextCapitalization.none,
            focusId: _codeFocus,
            onFieldSubmitted: nextPage),
      ],
    );
  }
}