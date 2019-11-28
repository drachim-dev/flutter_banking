import 'package:flutter_banking/locator.dart';
import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/model/institute.dart';
import 'package:flutter_banking/services/firebase_service.dart';

class AccountService {
  FirebaseService _firebaseService = locator<FirebaseService>();

  Stream<List<Account>> get accounts => _firebaseService.accounts;
  Stream<List<Institute>> get institutes => _firebaseService.institutes;

  Future<void> addAccount(Account account) async {
    List<Institute> instituteList = await institutes.first;
    account.institute = instituteList.first;

    return _firebaseService.addAccount(account.toMap());
  }

  Stream<List<Institute>> getInstitutes(String bic) =>
      _firebaseService.institutes;
}