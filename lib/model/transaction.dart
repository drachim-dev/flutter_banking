import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/model/purpose.dart';

class Transaction {
  final String documentID;
  Account ownAccount;
  final DocumentReference ownAccountRef;
  Account foreignAccount;
  final DocumentReference foreignAccountRef;
  DateTime date;
  String usageText;
  double amount;
  final Purpose purpose;

  Transaction({
    this.documentID,
    @required this.ownAccount,
    this.ownAccountRef,
    @required this.foreignAccount,
    this.foreignAccountRef,
    @required this.date,
    this.usageText,
    @required this.amount,
    @required this.purpose,
  });

  Map<String, dynamic> toMap() => {
        'ownAccount': ownAccount.documentReference,
        'foreignAccount': foreignAccount.documentReference,
        'date': Timestamp.fromDate(date),
        'usageText': usageText,
        'amount': amount,
        'purpose': '',
      };

  Transaction.fromSnapshot(DocumentSnapshot snapshot)
      : documentID = snapshot.documentID,
        ownAccountRef = snapshot['ownAccount'],
        foreignAccountRef = snapshot['foreignAccount'],
        date = snapshot['date'].toDate(),
        usageText = snapshot['usageText'] ?? '',
        amount = snapshot['amount']?.toDouble() ?? 0,
        purpose = Purpose.BankTransfer;
}
