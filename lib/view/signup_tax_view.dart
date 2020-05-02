import 'package:flutter/material.dart';
import 'package:flutter_banking/view/signup_form.dart';

class SignUpTaxView extends StatelessWidget {
  final FocusNode _countryFocus = FocusNode();
  final FocusNode _taxId = FocusNode();

  final VoidCallback nextPage;

  SignUpTaxView({this.nextPage});

  @override
  Widget build(BuildContext context) {
    return SignUpFormListView(
      list: [
        Text("In which country are you taxable?"),
        SignUpFormField(
          'Country',
          keyboardType: TextInputType.number,
          textCapitalization: TextCapitalization.none,
          focusId: _countryFocus,
          nextFocusId: _taxId,
        ),
        SignUpFormField('Tax ID (optional)',
            keyboardType: TextInputType.number,
            textCapitalization: TextCapitalization.words,
            helperText:
                "If you don't know your tax id, we will determine it automatically",
            focusId: _taxId,
            onFieldSubmitted: nextPage),
        OutlineButton(onPressed: () {}, child: Text('Add another country')),
      ],
    );
  }
}
