import 'package:flutter/material.dart';
import 'package:flutter_banking/view/signup_form.dart';
import 'package:flutter_banking/widgets/signup_title.dart';
import 'package:flutter_banking/widgets/verification_code.dart';

class SignUpSecurityCode extends StatelessWidget {
  final String title;
  final VoidCallback nextPage;

  SignUpSecurityCode({this.title, this.nextPage});

  @override
  Widget build(BuildContext context) {
    return SignUpFormListView(
      children: [
        SignUpTitle(title: title),
        VerificationCode(itemCount: 4, hidden: true),
      ],
    );
  }
}
