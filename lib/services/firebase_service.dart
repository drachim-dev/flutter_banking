import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/model/account_type.dart';
import 'package:flutter_banking/model/institute.dart';
import 'package:flutter_banking/model/purpose.dart';
import 'package:flutter_banking/model/transaction.dart';

class FirebaseService {
  var account1 = Account(
      owner: 'Tim Wiechmann',
      institute: Institute(name: 'OLB', bic: 'OLBODEH2XXX'),
      accountType: AccountType.CheckingAccount,
      name: 'Servicekonto Gold',
      number: 'DE11111111111111111111',
      balance: 10000.0);
  var account2 = Account(
      owner: 'Tim Wiechmann',
      institute: Institute(name: 'Curve'),
      accountType: AccountType.CreditCard,
      name: 'Curve Blue',
      number: '4513258658760869',
      balance: 500.0);

  Future<List<Account>> getAccounts(int userId) async {
    Future.delayed(Duration(seconds: 2));

    var accounts = List<Account>();
    accounts.add(account1);
    accounts.add(account2);

    return accounts;
  }

  Future<List<Transaction>> getTransactions(String accountNumber) async {
    await Future.delayed(Duration(seconds: 1));

    var transactions = List<Transaction>();
    transactions = List();

    transactions.addAll(List.generate(4, (int index) {
      var date = DateTime.now().subtract(Duration(days: 30 * index + 1));
      date = DateTime(date.year, date.month, date.day);

      return Transaction(
          ownAccount: account2,
          foreignAccount: Account(
              owner: 'Spotify',
              institute: Institute(name: 'Nordax Bank'),
              number: '123'),
          date: date,
          usageText: 'Rechnung ${date.month}/2019',
          purpose: Purpose.DirectDebit,
          amount: -100.00);
    }));

    transactions.addAll(List.generate(10, (int index) {
      var date = DateTime.now().subtract(Duration(days: 30 * index + 1));
      date = DateTime(date.year, date.month, date.day);

      return Transaction(
          ownAccount: account1,
          date: date,
          foreignAccount: Account(
              owner: 'OLB', institute: Institute(name: 'OLB'), number: '123'),
          usageText: 'Gehalt ${date.month}/2019',
          purpose: Purpose.BankTransfer,
          amount: 1800.00);
    }));

    // sort by date
    transactions.sort((t1, t2) => t2.date.compareTo(t1.date));

    return transactions;
  }
}
