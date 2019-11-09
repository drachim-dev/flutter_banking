import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_banking/common/colors.dart';
import 'package:flutter_banking/common/masked_text_input_formatter.dart';
import 'package:flutter_banking/common/dimensions.dart';
import 'package:flutter_banking/view/transparent_app_bar.dart';

class AddContactView extends StatefulWidget {
  @override
  _AddContactViewState createState() => _AddContactViewState();
}

class _AddContactViewState extends State<AddContactView> {
  TextInputFormatter _ibanFormatter = MaskedTextInputFormatter(mask: 'xxxx xxxx xxxx xxxx xxxx xx', separator: ' ');
  String _ibanErrorText;
  bool _ibanSuccess = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle hintStyle =
        theme.textTheme.body2.copyWith(color: MyColor.grey);

    return Stack(children: [
      Scaffold(
        appBar: TransparentAppBar(
          title: Text('Add contact'),
        ),
        body: ListView(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.listItemPaddingHorizontal, vertical: 32),
            children: [
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding:
                          const EdgeInsets.only(left: 16, bottom: 6, right: 20),
                      child: Icon(Icons.person),
                    ),
                    hintText: 'Name and surname'),
              ),
              SizedBox(height: 32),
              TextFormField(
                inputFormatters: [
                  _ibanFormatter
                ],
                onFieldSubmitted: (value) => _validateIban(value),
                decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding:
                          const EdgeInsets.only(left: 16, bottom: 6, right: 20),
                      child: Icon(Icons.account_balance),
                    ),
                    hintText: 'IBAN',
                  errorText: _ibanErrorText,
                ),
              ),
              SizedBox(height: 16),
              if (_ibanSuccess) Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1, child: Text('OLBODEH2XXX', style: hintStyle)),
                    Expanded(
                        flex: 2,
                        child: Text('Oldenburgische Landesbank AG',
                            style: hintStyle)),
                  ],
                ),
              ),
              SizedBox(height: 32),
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding:
                          const EdgeInsets.only(left: 16, bottom: 6, right: 20),
                      child: Icon(Icons.note),
                    ),
                    hintText: 'Note'),
              ),
            ]),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text('Add contact'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text('Add & Send money'),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ]);
  }

  void _validateIban(String value) {
    var errorText = _validateChecksum(value);
    setState(() {
      _ibanErrorText = errorText;
      _ibanSuccess = errorText == null;
    });
  }

  _validateChecksum (String value) {
    if (value.isEmpty) {
      return 'Must not be empty';
    }

    Map<String, int> codeLengths = {
      'AD': 24, 'AE': 23, 'AT': 20, 'AZ': 28, 'BA': 20, 'BE': 16, 'BG': 22, 'BH': 22, 'BR': 29,
      'CH': 21, 'CR': 21, 'CY': 28, 'CZ': 24, 'DE': 22, 'DK': 18, 'DO': 28, 'EE': 20, 'ES': 24,
      'FI': 18, 'FO': 18, 'FR': 27, 'GB': 22, 'GI': 23, 'GL': 18, 'GR': 27, 'GT': 28, 'HR': 21,
      'HU': 28, 'IE': 22, 'IL': 23, 'IS': 26, 'IT': 27, 'JO': 30, 'KW': 30, 'KZ': 20, 'LB': 28,
      'LI': 21, 'LT': 20, 'LU': 20, 'LV': 21, 'MC': 27, 'MD': 24, 'ME': 22, 'MK': 19, 'MR': 27,
      'MT': 31, 'MU': 30, 'NL': 18, 'NO': 15, 'PK': 24, 'PL': 28, 'PS': 29, 'PT': 25, 'QA': 29,
      'RO': 24, 'RS': 22, 'SA': 24, 'SE': 24, 'SI': 19, 'SK': 24, 'SM': 27, 'TN': 24, 'TR': 26
    };

    // replace all non alphanumeric chars
    String iban = value.toUpperCase().replaceAll(RegExp('[^A-Z0-9]'), '');

    // match and capture (0) the country code, (1) the check digits, and (2) the rest
    var matches = RegExp(r'^([A-Z]{2})(\d{2})(\d+)').allMatches(iban);
    if(matches.length == 0) {
      return 'Wrong format';
    }

    var fragment = matches.first;

    // check syntax and length
    if (iban.length != codeLengths[fragment.group(1)]) {
      return 'The iban you have entered is wrong';
    }

    // convert country code to int
    var codeCountry = (fragment[1].codeUnitAt(0) - 55).toString() + (fragment[1].codeUnitAt(1) - 55).toString();

    // rearrange country code and check digits
    var digits = fragment[3] + codeCountry + fragment[2];

    // final check
    BigInt checksum = BigInt.parse(digits) % BigInt.from(97);
    if(checksum.toInt() != 1) {
      return 'The iban you have entered is wrong';
    }

    return null;
  }

}