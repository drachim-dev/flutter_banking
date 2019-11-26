import 'dart:async';

import 'package:flutter_banking/locator.dart';
import 'package:flutter_banking/model/transaction.dart';
import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/services/transaction_service.dart';
import 'package:flutter_banking/viewmodel/base_model.dart';

class AddTransactionOverviewModel extends BaseModel {
  final TransactionService _transactionService = locator<TransactionService>();

  Future<void> addTransaction(Transaction transaction) {
    transaction.date = DateTime.now();
    return _transactionService.addTransaction(transaction);
  }
}
