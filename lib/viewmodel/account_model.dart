import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/locator.dart';
import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/services/transaction_service.dart';
import 'package:flutter_banking/viewmodel/base_model.dart';

class AccountModel extends BaseModel {
  TransactionService _transactionService = locator<TransactionService>();

  List<Account> get accounts => _transactionService.accounts;

  Future getAccounts(int userId) async {
    setState(ViewState.Busy);
    await _transactionService.getAccounts(userId);
    setState(ViewState.Idle);
  }
}