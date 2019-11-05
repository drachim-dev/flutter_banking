import 'package:flutter_banking/locator.dart';
import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/model/transaction.dart';
import 'package:flutter_banking/services/firebase_service.dart';

class TransactionService {
  FirebaseService _firebaseService = locator<FirebaseService>();

  List<Account> _accounts;
  List<Account> get accounts => _accounts;

  List<Transaction> _transactions;
  List<Transaction> get transactions => _transactions;

  Future getAccounts(int userId) async {
    _accounts = await _firebaseService.getAccounts(userId);
  }

  Future getTransactions(String accountIban) async {
    _transactions = await _firebaseService.getTransactions(accountIban);
  }
}