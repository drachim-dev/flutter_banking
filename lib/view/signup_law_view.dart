import 'package:flutter/material.dart';
import 'package:flutter_banking/view/signup_form.dart';

class SignUpLawView extends StatelessWidget {
  final FocusNode _nationalityFocus = FocusNode();
  final FocusNode _placeOfBirthFocus = FocusNode();
  final FocusNode _countryOfBirthFocus = FocusNode();

  final VoidCallback nextPage;

  SignUpLawView({this.nextPage});

  @override
  Widget build(BuildContext context) {
    return SignUpFormListView(
      list: [
        Text("What is your nationality?"),
        SignUpFormField(
          'Nationality',
          keyboardType: TextInputType.number,
          textCapitalization: TextCapitalization.none,
          focusId: _nationalityFocus,
          nextFocusId: _placeOfBirthFocus,
        ),
        Text("Where were you born?"),
        SignUpFormField(
          'Place of birth',
          keyboardType: TextInputType.number,
          textCapitalization: TextCapitalization.none,
          focusId: _placeOfBirthFocus,
          nextFocusId: _countryOfBirthFocus,
        ),
        SignUpFormField(
          'Country of birth',
          keyboardType: TextInputType.number,
          textCapitalization: TextCapitalization.none,
          focusId: _countryOfBirthFocus,
          onFieldSubmitted: nextPage,
        ),
      ],
    );
  }
}
