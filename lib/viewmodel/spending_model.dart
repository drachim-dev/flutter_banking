import 'dart:async';

import 'package:flutter_banking/locator.dart';
import 'package:flutter_banking/model/transaction.dart';
import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/services/transaction_service.dart';
import 'package:flutter_banking/viewmodel/base_model.dart';

class SpendingModel extends BaseModel {
  final TransactionService _transactionService = locator<TransactionService>();
  StreamSubscription _transactionSubscription;

  List<Transaction> transactions;

  SpendingModel() {
    _transactionSubscription = _transactionService.transactions.listen(_onTransactionsUpdated);
  }

  @override
  void dispose() {
    _transactionSubscription.cancel();
    super.dispose();
  }

  void _onTransactionsUpdated(List<Transaction> transactions) {
    this.transactions = transactions;

    if (transactions == null) {
      setState(ViewState.Busy);
    } else {
      setState(transactions.isEmpty
          ? ViewState.NoDataAvailable
          : ViewState.DataFetched);
    }
  }
}