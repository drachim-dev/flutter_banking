import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_banking/common/colors.dart';
import 'package:flutter_banking/common/consts.dart';
import 'package:flutter_banking/common/masked_text_input_formatter.dart';
import 'package:flutter_banking/common/dimens.dart';
import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/model/account_type.dart';
import 'package:flutter_banking/model/institute.dart';
import 'package:flutter_banking/model/transaction.dart';
import 'package:flutter_banking/router.gr.dart';
import 'package:flutter_banking/view/base_view.dart';
import 'package:flutter_banking/view/transparent_app_bar.dart';
import 'package:flutter_banking/viewmodel/add_account_model.dart';

class AddAccountView extends StatefulWidget {
  final bool createOwnAccount;

  const AddAccountView({Key key, @required this.createOwnAccount})
      : super(key: key);

  @override
  _AddAccountViewState createState() =>
      _AddAccountViewState(this.createOwnAccount);
}

class _AddAccountViewState extends State<AddAccountView> {
  final TextInputFormatter _ibanFormatter = MaskedTextInputFormatter(
      mask: Consts.ibanMask, separator: Consts.ibanSeparator);

  final bool _createOwnAccount;

  String _ibanErrorText;
  bool _ibanSuccess = false;
  Account _account;

  _AddAccountViewState(this._createOwnAccount);

  @override
  void initState() {
    super.initState();

    _account = Account(customerId: _createOwnAccount ? '1000000000' : null);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BaseView<AddAccountModel>(builder: (_, model, child) {
      return Stack(children: [
        Scaffold(
          appBar: _buildAppBar(theme),
          body: _buildInputFields(theme),
        ),
        _buildBottomBar(model)
      ]);
    });
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    String title = _createOwnAccount ? 'Add account' : 'Add contact';
    return TransparentAppBar(
      theme: theme,
      title: Text(title),
    );
  }

  Align _buildBottomBar(AddAccountModel model) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            _buildAddButton(model),
            if (!_createOwnAccount) _buildSendMoneyButton(model),
          ],
        ),
      ),
    );
  }

  Expanded _buildAddButton(AddAccountModel model) {
    String persistText = _createOwnAccount ? 'Save' : 'Add';

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
          onPressed: () {
            _createOwnAccount
                ? model.addAccount(_account)
                : model.addContact(_account);
            Navigator.of(context).pop();
          },
          child: Text(persistText),
        ),
      ),
    );
  }

  Expanded _buildSendMoneyButton(AddAccountModel model) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
          onPressed: () {
            model.addAccount(_account);

            // create transaction
            Transaction _transaction = Transaction(foreignAccount: _account);

            // pass transaction to new route
            ExtendedNavigator.rootNavigator.pushNamed(
                Routes.amountSelectionView,
                arguments:
                    AmountSelectionViewArguments(transaction: _transaction));
          },
          child: Text('Add & Send money'),
        ),
      ),
    );
  }

  ListView _buildInputFields(ThemeData theme) {
    final TextStyle hintStyle =
        theme.textTheme.bodyText1.copyWith(color: MyColor.grey);

    return ListView(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimens.listItemPaddingHorizontal, vertical: 32),
        children: [
          if (_createOwnAccount) _buildAccountTypeField(),
          if (_createOwnAccount) SizedBox(height: 24),
          _buildNameField(),
          SizedBox(height: 32),
          _buildAccountNumberField(),
          SizedBox(height: 16),
          if (_ibanSuccess) _buildBankDetailsHint(hintStyle),
          SizedBox(height: 32),
          _buildNotesField(),
        ]);
  }

  DropdownButton _buildAccountTypeField() {
    return DropdownButton(
      value: _account.accountType,
      isExpanded: true,
      onChanged: (value) => setState(() => _account.accountType = value),
      items: AccountType.values
          .map((type) => DropdownMenuItem(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, bottom: 6, right: 20),
                      child: Icon(AccountTypeHelper.getIcon(type)),
                    ),
                    Text(AccountTypeHelper.getValue(type)),
                  ],
                ),
                value: type,
              ))
          .toList(),
    );
  }

  TextFormField _buildNameField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      onChanged: (value) => _account.customer = value,
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 6, right: 20),
            child: Icon(Icons.person),
          ),
          hintText: 'Name'),
    );
  }

  TextFormField _buildAccountNumberField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.characters,
      inputFormatters: [_ibanFormatter],
      onChanged: (value) {
        _account.number = value;
        _account.institute = Institute();
      },
      onFieldSubmitted: (value) => _validateIban(value),
      decoration: InputDecoration(
        prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 6, right: 20),
            child: Icon(Icons.edit)),
        hintText: 'IBAN',
        errorText: _ibanErrorText,
      ),
    );
  }

  Padding _buildBankDetailsHint(TextStyle hintStyle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text('OLBODEH2XXX', style: hintStyle)),
          Expanded(
              flex: 2,
              child: Text('Oldenburgische Landesbank AG', style: hintStyle)),
        ],
      ),
    );
  }

  TextFormField _buildNotesField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 6, right: 20),
            child: Icon(Icons.note),
          ),
          hintText: 'Note'),
    );
  }

  void _validateIban(String value) {
    var errorText = _validateChecksum(value);
    setState(() {
      _ibanErrorText = errorText;
      _ibanSuccess = errorText == null;
    });
  }

  _validateChecksum(String value) {
    if (value.isEmpty) {
      return 'Must not be empty';
    }

    Map<String, int> codeLengths = {
      'AD': 24,
      'AE': 23,
      'AT': 20,
      'AZ': 28,
      'BA': 20,
      'BE': 16,
      'BG': 22,
      'BH': 22,
      'BR': 29,
      'CH': 21,
      'CR': 21,
      'CY': 28,
      'CZ': 24,
      'DE': 22,
      'DK': 18,
      'DO': 28,
      'EE': 20,
      'ES': 24,
      'FI': 18,
      'FO': 18,
      'FR': 27,
      'GB': 22,
      'GI': 23,
      'GL': 18,
      'GR': 27,
      'GT': 28,
      'HR': 21,
      'HU': 28,
      'IE': 22,
      'IL': 23,
      'IS': 26,
      'IT': 27,
      'JO': 30,
      'KW': 30,
      'KZ': 20,
      'LB': 28,
      'LI': 21,
      'LT': 20,
      'LU': 20,
      'LV': 21,
      'MC': 27,
      'MD': 24,
      'ME': 22,
      'MK': 19,
      'MR': 27,
      'MT': 31,
      'MU': 30,
      'NL': 18,
      'NO': 15,
      'PK': 24,
      'PL': 28,
      'PS': 29,
      'PT': 25,
      'QA': 29,
      'RO': 24,
      'RS': 22,
      'SA': 24,
      'SE': 24,
      'SI': 19,
      'SK': 24,
      'SM': 27,
      'TN': 24,
      'TR': 26
    };

    // replace all non alphanumeric chars
    String iban = value.toUpperCase().replaceAll(RegExp('[^A-Z0-9]'), '');

    // match and capture (0) the country code, (1) the check digits, and (2) the rest
    var matches = RegExp(r'^([A-Z]{2})(\d{2})(\d+)').allMatches(iban);
    if (matches.length == 0) {
      return 'Wrong format';
    }

    var fragment = matches.first;

    // check syntax and length
    if (iban.length != codeLengths[fragment.group(1)]) {
      return 'The iban you have entered is wrong';
    }

    // convert country code to int
    var codeCountry = (fragment[1].codeUnitAt(0) - 55).toString() +
        (fragment[1].codeUnitAt(1) - 55).toString();

    // rearrange country code and check digits
    var digits = fragment[3] + codeCountry + fragment[2];

    // final check
    BigInt checksum = BigInt.parse(digits) % BigInt.from(97);
    if (checksum.toInt() != 1) {
      return 'The iban you have entered is wrong';
    }

    return null;
  }
}
