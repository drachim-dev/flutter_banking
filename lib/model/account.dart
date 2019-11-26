import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_banking/model/account_type.dart';
import 'package:flutter_banking/model/institute.dart';

class Account {
  final String documentID;
  final DocumentReference documentReference;
  final String owner, number, name;
  Institute institute;
  final DocumentReference instituteRef;
  final AccountType accountType;
  final double balance;

  Account(
      {this.documentID,
      this.documentReference,
      @required this.owner,
      @required this.number,
      this.institute,
      @required this.instituteRef,
      this.accountType,
      this.name,
      this.balance});

  Account.fromSnapshot(DocumentSnapshot snapshot)
      : documentID = snapshot.documentID,
        documentReference = snapshot.reference,
        owner = snapshot['owner'] ?? '',
        number = snapshot['number'],
        instituteRef = snapshot['institute'],
        accountType = AccountType.CheckingAccount,
        name = snapshot['name'] ?? '',
        balance = snapshot['balance']?.toDouble() ?? 0;
}
