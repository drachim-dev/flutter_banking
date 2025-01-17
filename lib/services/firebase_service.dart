import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/model/institute.dart';
import 'package:flutter_banking/model/place.dart';
import 'package:flutter_banking/model/transaction.dart';
import 'package:rxdart/subjects.dart';

class FirebaseService {
  final StreamController<List<Account>> _accountController = BehaviorSubject();
  final StreamController<List<Account>> _contactController = BehaviorSubject();
  final StreamController<List<Institute>> _instituteController =
      BehaviorSubject();
  final StreamController<List<Transaction>> _transactionController =
      BehaviorSubject();
  final StreamController<List<Place>> _placeController = BehaviorSubject();

  Stream<List<Account>> get accounts => _accountController.stream;
  Stream<List<Account>> get contacts => _contactController.stream;
  Stream<List<Institute>> get institutes => _instituteController.stream;
  Stream<List<Transaction>> get transactions => _transactionController.stream;
  Stream<List<Place>> get places => _placeController.stream;

  FirebaseService() {
    firestore.Firestore.instance
        .collection('accounts')
        .where('customerId', isEqualTo: '1000000000')
        .snapshots()
        .listen(_accountsAdded);

    firestore.Firestore.instance
        .collection('accounts')
        .where('customerId', isNull: true)
        .snapshots()
        .listen(_contactsAdded);

    firestore.Firestore.instance
        .collection('institutes')
        .snapshots()
        .listen(_institutesAdded);

    firestore.Firestore.instance
        .collection('transactions')
        .snapshots()
        .listen(_transactionsAdded);

    firestore.Firestore.instance
        .collection('places')
        .snapshots()
        .listen(_placesAdded);
  }

  Future<void> _accountsAdded(firestore.QuerySnapshot snapshot) async {
    List<Account> accounts = [];

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

  Future<void> addAccount(Map<String, dynamic> account) {
    return firestore.Firestore.instance.collection('accounts').add(account);
  }

  Future<void> deleteAccount(String id) {
    return firestore.Firestore.instance
        .collection('accounts')
        .document(id)
        .delete();
  }

  Future<void> _contactsAdded(firestore.QuerySnapshot snapshot) async {
    List<Account> contacts = [];

    for (var document in snapshot.documents) {
      var contact = await _getContactFromSnapshot(document);
      contacts.add(contact);
    }
    _contactController.add(contacts);
  }

  Future<Account> _getContactFromSnapshot(
      firestore.DocumentSnapshot snapshot) async {
    return _getAccountFromSnapshot(snapshot);
  }

  Future<void> addContact(Map<String, dynamic> contact) {
    return addAccount(contact);
  }

  Future<void> deleteContact(String id) {
    return deleteAccount(id);
  }

  Future<void> _institutesAdded(firestore.QuerySnapshot snapshot) async {
    List<Institute> institutes = [];

    for (var document in snapshot.documents) {
      var institute = await _getInstituteFromSnapshot(document);
      institutes.add(institute);
    }
    _instituteController.add(institutes);
  }

  Future<Institute> _getInstituteFromSnapshot(
      firestore.DocumentSnapshot snapshot) async {
    return Institute.fromSnapshot(snapshot);
  }

  Future<void> _transactionsAdded(firestore.QuerySnapshot snapshot) async {
    List<Transaction> transactions = [];

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

  Future<void> _placesAdded(firestore.QuerySnapshot snapshot) async {
    List<Place> places = [];

    snapshot.documents
        .forEach((doc) async => places.add(Place.fromSnapshot(doc)));
    _placeController.add(places);
  }
}