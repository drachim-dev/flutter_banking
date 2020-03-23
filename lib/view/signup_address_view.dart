import 'package:flutter/material.dart';
import 'package:flutter_banking/common/dimens.dart';
import 'package:flutter_banking/view/signup_form.dart';

class SignUpAddressView extends StatelessWidget {
  final FocusNode _streetFocus = FocusNode();
  final FocusNode _houseNumberFocus = FocusNode();
  final FocusNode _postCodeFocus = FocusNode();
  final FocusNode _placeFocus = FocusNode();

  final VoidCallback nextPage;

  SignUpAddressView({this.nextPage});

  @override
  Widget build(BuildContext context) {
    return SignUpFormListView(
      list: [
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: SignUpFormField('Street',
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  focusId: _streetFocus,
                  nextFocusId: _houseNumberFocus),
            ),
            SizedBox(width: Dimens.inputFieldHorizontalPadding,),
            Expanded(
              flex: 1,
              child: SignUpFormField('House',
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.characters,
                  focusId: _houseNumberFocus,
                  nextFocusId: _postCodeFocus),
            ),
          ],
        ),
        SignUpFormField('Post code',
            keyboardType: TextInputType.number,
            textCapitalization: TextCapitalization.characters,
            focusId: _postCodeFocus,
            nextFocusId: _placeFocus),
        SignUpFormField(
          'Place',
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          focusId: _placeFocus,
          onFieldSubmitted: nextPage,
        ),
      ],
    );
  }
}
