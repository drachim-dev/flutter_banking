import 'dart:async';

import 'package:flutter_banking/locator.dart';
import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/services/account_service.dart';
import 'package:flutter_banking/viewmodel/base_model.dart';

class AccountModel extends BaseModel {
  final AccountService _accountService = locator<AccountService>();
  StreamSubscription _accountsSubscription;

  List<Account> accounts;

  AccountModel() {
    _accountsSubscription = _accountService.accounts.listen(_onAccountsUpdated);
  }

  @override
  void dispose() {
    _accountsSubscription.cancel();
    super.dispose();
  }

  void _onAccountsUpdated(List<Account> accounts) {
    this.accounts = accounts;

    if (accounts == null) {
      setState(ViewState.Busy);
    } else {
      setState(accounts.isEmpty
          ? ViewState.NoDataAvailable
          : ViewState.DataFetched);
    }
  }

  Future<void> deleteAccount(Account account) {
    return _accountService.deleteAccount(account);
  }

}