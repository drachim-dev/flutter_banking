import 'package:flutter/material.dart';
import 'package:flutter_banking/view/signup_form.dart';
import 'package:flutter_banking/widgets/signup_title.dart';
import 'package:flutter_banking/widgets/verification_code.dart';

class SignUpMailView extends StatelessWidget {
  final FocusNode _mailFocus = FocusNode();
  final FocusNode _codeFocus = FocusNode();

  final String title, description;
  final VoidCallback nextPage;

  SignUpMailView({this.title, this.description, this.nextPage});

  @override
  Widget build(BuildContext context) {
    return SignUpFormListView(
      children: [
        SignUpTitle(title: title, description: description),
        SignUpFormField('E-Mail',
            autofillHints: [AutofillHints.email],
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.words,
            autofocus: false,
            focusId: _mailFocus,
            nextFocusId: _codeFocus),
        OutlineButton(onPressed: () {}, child: Text('Resend')),
        Text(
            "We've sent you an email containing a verification code. Please enter it here:"),
        VerificationCode(
          itemCount: 6,
          divider: true,
        ),
      ],
    );
  }
}
