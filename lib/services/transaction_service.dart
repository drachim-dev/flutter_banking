import 'package:flutter_banking/locator.dart';
import 'package:flutter_banking/model/transaction.dart';
import 'package:flutter_banking/services/firebase_service.dart';

class TransactionService {
  FirebaseService _firebaseService = locator<FirebaseService>();

  Stream<List<Transaction>> get transactions => _firebaseService.transactions;

  Future<void> addTransaction(Transaction transaction) {
    return _firebaseService.addTransaction(transaction.toMap());
  }
}
