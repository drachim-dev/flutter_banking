import 'package:flutter/material.dart';
import 'package:flutter_banking/common/dimens.dart';
import 'package:flutter_banking/view/signup_form.dart';

class SignUpNameView extends StatelessWidget {
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _dayOfBirthFocus = FocusNode();
  final FocusNode _monthOfBirthFocus = FocusNode();
  final FocusNode _yearOfBirthFocus = FocusNode();

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
        SignUpFormField(
          'Last name',
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
                keyboardType: TextInputType.number,
                focusId: _dayOfBirthFocus,
                nextFocusId: _monthOfBirthFocus,
              ),
            ),
            SizedBox(width: Dimens.inputFieldHorizontalPadding,),
            Expanded(
              child: SignUpFormField(
                'MM',
                keyboardType: TextInputType.number,
                focusId: _monthOfBirthFocus,
                nextFocusId: _yearOfBirthFocus,
              ),
            ),
            SizedBox(width: Dimens.inputFieldHorizontalPadding,),
            Expanded(
              child: SignUpFormField('JJJJ',
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
