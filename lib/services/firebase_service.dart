import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/model/institute.dart';
import 'package:flutter_banking/model/transaction.dart';
import 'package:rxdart/subjects.dart';

class FirebaseService {
  final StreamController<List<Account>> _accountController = BehaviorSubject();
  final StreamController<List<Transaction>> _transactionController =
      BehaviorSubject();

  Stream<List<Account>> get accounts => _accountController.stream;
  Stream<List<Transaction>> get transactions => _transactionController.stream;

  FirebaseService() {
    firestore.Firestore.instance
        .collection('accounts')
        .snapshots()
        .listen(_accountsAdded);

    firestore.Firestore.instance
        .collection('transactions')
        .snapshots()
        .listen(_transactionsAdded);
  }

  Future<void> _accountsAdded(firestore.QuerySnapshot snapshot) async {
    List<Account> accounts = List<Account>();

    for (var document in snapshot.documents) {
      var account = await _getAccountFromSnapshot(document);
      accounts.add(account);
    }
    _accountController.add(accounts);
  }

  Future<Account> _getAccountFromSnapshot(
      firestore.DocumentSnapshot snapshot) async {
    var account = Account.fromSnapshot(snapshot);
    var instituteRef = await account.instituteRef.get();
    account.institute = Institute.fromSnapshot(instituteRef);
    return account;
  }

  Future<void> _transactionsAdded(firestore.QuerySnapshot snapshot) async {
    List<Transaction> transactions = List<Transaction>();

    for (var document in snapshot.documents) {
      var transaction = Transaction.fromSnapshot(document);

      var ownAccountRef = await transaction.ownAccountRef.get();
      transaction.ownAccount = await _getAccountFromSnapshot(ownAccountRef);

      var foreignAccountRef = await transaction.foreignAccountRef.get();
      transaction.foreignAccount =
          await _getAccountFromSnapshot(foreignAccountRef);

      transactions.add(transaction);
    }

    // sort by date
    transactions.sort((t1, t2) => t2.date.compareTo(t1.date));

    _transactionController.add(transactions);
  }

  Future<void> addTransaction(Map<String, dynamic> transaction) {
    return firestore.Firestore.instance
        .collection('transactions')
        .add(transaction);
  }
}
