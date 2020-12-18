import 'package:flutter/material.dart';
import 'package:flutter_banking/common/dimens.dart';
import 'package:flutter_banking/view/signup_form.dart';
import 'package:flutter_banking/widgets/signup_title.dart';

class SignUpNameView extends StatelessWidget {
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _dayOfBirthFocus = FocusNode();
  final FocusNode _monthOfBirthFocus = FocusNode();
  final FocusNode _yearOfBirthFocus = FocusNode();

  final String title;
  final VoidCallback nextPage;

  SignUpNameView({this.title, this.nextPage});

  @override
  Widget build(BuildContext context) {
    return SignUpFormListView(
      children: [
        SignUpTitle(
          title: title,
        ),
        SignUpFormField('First name',
            autofillHints: [AutofillHints.name],
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            focusId: _firstNameFocus,
            nextFocusId: _lastNameFocus),
        SignUpFormField(
          'Last name',
          autofillHints: [AutofillHints.familyName],
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          focusId: _lastNameFocus,
          nextFocusId: _dayOfBirthFocus,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: SignUpFormField(
                'DD',
                autofillHints: [AutofillHints.birthdayDay],
                keyboardType: TextInputType.number,
                focusId: _dayOfBirthFocus,
                nextFocusId: _monthOfBirthFocus,
              ),
            ),
            SizedBox(
              width: Dimens.inputFieldHorizontalPadding,
            ),
            Expanded(
              child: SignUpFormField(
                'MM',
                autofillHints: [AutofillHints.birthdayMonth],
                keyboardType: TextInputType.number,
                focusId: _monthOfBirthFocus,
                nextFocusId: _yearOfBirthFocus,
              ),
            ),
            SizedBox(
              width: Dimens.inputFieldHorizontalPadding,
            ),
            Expanded(
              child: SignUpFormField('YYYY',
                  autofillHints: [AutofillHints.birthdayYear],
                  keyboardType: TextInputType.number,
                  focusId: _yearOfBirthFocus,
                  onFieldSubmitted: nextPage),
            ),
          ],
        ),
      ],
    );
  }
}
