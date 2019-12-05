import 'dart:async';

import 'package:flutter_banking/locator.dart';
import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/model/institute.dart';
import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/services/account_service.dart';
import 'package:flutter_banking/viewmodel/base_model.dart';

class AddAccountModel extends BaseModel {
  final AccountService _accountService = locator<AccountService>();
  StreamSubscription _institutesSubscription;

  List<Institute> institutes;

  AddAccountModel() {
    _institutesSubscription =
        _accountService.institutes.listen(_onInstitutesUpdated);
  }

  @override
  void dispose() {
    _institutesSubscription.cancel();
    super.dispose();
  }

  void _onInstitutesUpdated(List<Institute> institutes) {
    this.institutes = institutes;

    if (institutes == null) {
      setState(ViewState.Busy);
    } else {
      setState(institutes.isEmpty
          ? ViewState.NoDataAvailable
          : ViewState.DataFetched);
    }
  }

  Future<void> addAccount(Account account) {
    account.number = account.number.replaceAll(' ', '');
    return _accountService.addAccount(account);
  }

  Future<void> addContact(Account contact) {
    contact.number = contact.number.replaceAll(' ', '');
    return _accountService.addContact(contact);
  }
}
