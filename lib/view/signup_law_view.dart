import 'package:flutter/material.dart';
import 'package:flutter_banking/view/signup_form.dart';
import 'package:flutter_banking/widgets/signup_title.dart';

class SignUpLawView extends StatelessWidget {
  final FocusNode _nationalityFocus = FocusNode();
  final FocusNode _placeOfBirthFocus = FocusNode();
  final FocusNode _countryOfBirthFocus = FocusNode();

  final String title;
  final VoidCallback nextPage;

  SignUpLawView({this.title, this.nextPage});

  @override
  Widget build(BuildContext context) {
    return SignUpFormListView(
      children: [
        SignUpTitle(title: title),
        Text("What is your nationality?"),
        SignUpFormField(
          'Nationality',
          autofillHints: [AutofillHints.countryName],
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          focusId: _nationalityFocus,
          nextFocusId: _placeOfBirthFocus,
        ),
        Text("Where were you born?"),
        SignUpFormField(
          'Place of birth',
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          focusId: _placeOfBirthFocus,
          nextFocusId: _countryOfBirthFocus,
        ),
        SignUpFormField(
          'Country of birth',
          autofillHints: [AutofillHints.countryName],
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          focusId: _countryOfBirthFocus,
          onFieldSubmitted: nextPage,
        ),
      ],
    );
  }
}
