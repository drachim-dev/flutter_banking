import 'package:flutter/material.dart';
import 'package:flutter_banking/view/signup_form.dart';

class SignUpContactView extends StatelessWidget {
  final FocusNode _mailFocus = FocusNode();
  final FocusNode _codeFocus = FocusNode();

  final VoidCallback nextPage;

  SignUpContactView({this.nextPage});

  @override
  Widget build(BuildContext context) {
    return SignUpFormListView(
      list: [
        SignUpFormField('E-Mail',
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.words,
            focusId: _mailFocus,
            nextFocusId: _codeFocus),
        OutlineButton(onPressed: () {}, child: Text('Resend')),
        Text(
            "We've sent you an email containing a verification code. Please enter the code:"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 112, vertical: 8),
          child: ValidationFormField('Verification',
              keyboardType: TextInputType.number,
              focusId: _codeFocus,
              onFieldSubmitted: nextPage),
        ),
      ],
    );
  }
}
