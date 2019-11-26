import 'dart:async';

import 'package:flutter_banking/locator.dart';
import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/services/account_service.dart';
import 'package:flutter_banking/viewmodel/base_model.dart';

class ContactModel extends BaseModel {
  final AccountService _accountService = locator<AccountService>();
  StreamSubscription _accountsSubscription;

  List<Account> allContacts;
  List<Account> suggestedContacts;

  ContactModel() {
    _accountsSubscription = _accountService.accounts.listen(_onAccountsUpdated);
  }

  @override
  void dispose() {
    _accountsSubscription.cancel();
    super.dispose();
  }

  void _onAccountsUpdated(List<Account> accounts) {
    this.allContacts = accounts;
    this.suggestedContacts = accounts.take(1).toList();
    
    if (accounts == null) {
      setState(ViewState.Busy);
    } else {
      setState(accounts.isEmpty
          ? ViewState.NoDataAvailable
          : ViewState.DataFetched);
    }
  }
}