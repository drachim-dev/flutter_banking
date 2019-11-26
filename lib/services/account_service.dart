import 'package:flutter_banking/locator.dart';
import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/services/firebase_service.dart';

class AccountService {
  FirebaseService _firebaseService = locator<FirebaseService>();
  
  Stream<List<Account>> get accounts => _firebaseService.accounts;
}
