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
                decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding:
                          const EdgeInsets.only(left: 16, bottom: 6, right: 20),
                      child: Icon(Icons.account_balance),
                    ),
                    hintText: 'IBAN'),
              ),
              SizedBox(height: 16),
              Padding(
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
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RaisedButton(
            onPressed: () {},
            child: Text('Add contact'),
          ),
        ),
      )
    ]);
  }
}
