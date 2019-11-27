import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_banking/model/account_type.dart';
import 'package:flutter_banking/model/institute.dart';

class Account {
  final String documentID;
  final DocumentReference documentReference;
  final String customerId;
  String owner, number, name;
  Institute institute;
  final DocumentReference instituteRef;
  final AccountType accountType;
  final double balance;

  Account(
      {this.documentID,
      this.documentReference,
      this.customerId,
      this.owner,
      this.number,
      this.institute,
      this.instituteRef,
      this.accountType,
      this.name,
      this.balance});

    Map<String, dynamic> toMap() => {
        'customerId': customerId,
        'owner': owner,
        'number': number.toUpperCase(),
        'name': name,
        'institute': institute.documentReference,
        'accountType': '',
        'balance': balance,
      };

  Account.fromSnapshot(DocumentSnapshot snapshot)
      : documentID = snapshot.documentID,
        documentReference = snapshot.reference,
        customerId = snapshot['customerId'],
        owner = snapshot['owner'] ?? '',
        number = snapshot['number'],
        instituteRef = snapshot['institute'],
        accountType = AccountType.CheckingAccount,
        name = snapshot['name'] ?? '',
        balance = snapshot['balance']?.toDouble() ?? 0;
}