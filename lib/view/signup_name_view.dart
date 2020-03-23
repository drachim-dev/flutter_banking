import 'package:flutter/material.dart';
import 'package:flutter_banking/view/signup_form.dart';

class SignUpNameView extends StatelessWidget {
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();

  final VoidCallback nextPage;

  SignUpNameView({this.nextPage});

  @override
  Widget build(BuildContext context) {
    return SignUpFormListView(
      list: [
        SignUpFormField('First name',
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            focusId: _firstNameFocus,
            nextFocusId: _lastNameFocus),
        SignUpFormField('Last name',
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            focusId: _lastNameFocus,
            onFieldSubmitted: nextPage),
      ],
    );
  }
}
