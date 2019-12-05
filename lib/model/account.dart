import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_banking/model/account_type.dart';
import 'package:flutter_banking/model/institute.dart';

class Account {
  final String documentID;
  final DocumentReference documentReference;
  final String customerId;
  String customer, number, name;
  Institute institute;
  final DocumentReference instituteRef;
  AccountType accountType;
  final double balance;

  Account(
      {this.documentID,
      this.documentReference,
      this.customerId,
      this.customer,
      this.number,
      this.institute,
      this.instituteRef,
      this.accountType = AccountType.CheckingAccount,
      this.name,
      this.balance});

  Map<String, dynamic> toMap() => {
        'customerId': customerId,
        'customer': customer,
        'number': number.replaceAll(' ', '').toUpperCase(),
        'name': name,
        'institute': institute.documentReference,
        'accountType': AccountTypeHelper.getValue(accountType),
        'balance': balance,
      };

  Account.fromSnapshot(DocumentSnapshot snapshot)
      : documentID = snapshot.documentID,
        documentReference = snapshot.reference,
        customerId = snapshot['customerId'] ?? '',
        customer = snapshot['customer'] ?? '',
        number = snapshot['number'],
        instituteRef = snapshot['institute'],
        accountType = AccountTypeHelper.fromValue(snapshot['accountType']),
        name = snapshot['name'] ?? '',
        balance = snapshot['balance']?.toDouble() ?? 0;
}