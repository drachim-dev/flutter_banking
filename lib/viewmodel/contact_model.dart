import 'dart:async';

import 'package:flutter_banking/locator.dart';
import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/services/account_service.dart';
import 'package:flutter_banking/viewmodel/base_model.dart';

class ContactModel extends BaseModel {
  final AccountService _accountService = locator<AccountService>();
  StreamSubscription _accountSubscription;

  List<Account> allContacts;
  List<Account> suggestedContacts;

  ContactModel() {
    _accountSubscription = _accountService.contacts.listen(_onContactsUpdated);
  }

  @override
  void dispose() {
    _accountSubscription.cancel();
    super.dispose();
  }

  void _onContactsUpdated(List<Account> contacts) {
    this.allContacts = contacts;
    this.suggestedContacts = contacts.take(1).toList();

    if (contacts == null) {
      setState(ViewState.Busy);
    } else {
      setState(
          contacts.isEmpty ? ViewState.NoDataAvailable : ViewState.DataFetched);
    }
  }
}
