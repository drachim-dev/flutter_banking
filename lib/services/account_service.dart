import 'package:flutter_banking/locator.dart';
import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/model/institute.dart';
import 'package:flutter_banking/services/firebase_service.dart';

class AccountService {
  FirebaseService _firebaseService = locator<FirebaseService>();

  Stream<List<Account>> get accounts => _firebaseService.accounts;
  Stream<List<Account>> get contacts => _firebaseService.contacts;
  Stream<List<Institute>> get institutes => _firebaseService.institutes;

  Future<void> addAccount(Account account) async {
    List<Institute> instituteList = await institutes.first;
    account.institute = instituteList.first;

    return _firebaseService.addAccount(account.toMap());
  }

  Future<void> deleteAccount(Account account) async {
    return _firebaseService.deleteAccount(account.documentID);
  }

  Future<void> addContact(Account contact) async {
    List<Institute> instituteList = await institutes.first;
    contact.institute = instituteList.first;

    return _firebaseService.addContact(contact.toMap());
  }

  Future<void> deleteContact(Account contact) async {
    return _firebaseService.deleteContact(contact.documentID);
  }

  Stream<List<Institute>> getInstitutes(String bic) =>
      _firebaseService.institutes;
}