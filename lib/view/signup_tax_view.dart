import 'package:flutter/material.dart';
import 'package:flutter_banking/view/signup_form.dart';
import 'package:flutter_banking/widgets/signup_title.dart';

class SignUpTaxView extends StatelessWidget {
  final FocusNode _countryFocus = FocusNode();
  final FocusNode _taxId = FocusNode();

  final String title, description;
  final VoidCallback nextPage;

  SignUpTaxView({this.title, this.description, this.nextPage});

  @override
  Widget build(BuildContext context) {
    return SignUpFormListView(
      children: [
        SignUpTitle(title: title, description: description),
        SignUpFormField(
          'Germany',
          readonly: true,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          focusId: _countryFocus,
          nextFocusId: _taxId,
        ),
        SignUpFormField('Tax ID (optional)',
            keyboardType: TextInputType.number,
            helperText:
                "If you don't know your tax id, we will determine it automatically",
            focusId: _taxId,
            onFieldSubmitted: nextPage),
        OutlineButton(onPressed: () {}, child: Text('Add another country')),
      ],
    );
  }
}
