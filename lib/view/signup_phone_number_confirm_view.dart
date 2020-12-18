import 'package:flutter/material.dart';
import 'package:flutter_banking/view/signup_form.dart';
import 'package:flutter_banking/widgets/signup_title.dart';
import 'package:flutter_banking/widgets/verification_code.dart';

class SignUpPhoneNumberConfirmView extends StatelessWidget {
  final String title, subtitle;
  final VoidCallback nextPage;

  SignUpPhoneNumberConfirmView({this.title, this.subtitle, this.nextPage});

  @override
  Widget build(BuildContext context) {
    return SignUpFormListView(
      children: [
        SignUpTitle(title: title, subtitle: subtitle),
        VerificationCode(
          itemCount: 6,
          divider: true,
        ),
      ],
    );
  }
}
