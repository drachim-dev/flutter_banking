import 'package:flutter_banking/locator.dart';
import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/model/institute.dart';
import 'package:flutter_banking/services/firebase_service.dart';

class ContactService {
  FirebaseService _firebaseService = locator<FirebaseService>();
  
  Stream<List<Account>> get contacts => _firebaseService.contacts;
  Stream<List<Institute>> get institutes => _firebaseService.institutes;

  Future<void> addContact(Account contact) async{
    List<Institute> instituteList = await institutes.first;
    contact.institute = instituteList.first;

    return _firebaseService.addContact(contact.toMap());
  }

  Stream<List<Institute>> getInstitutes(String bic) => _firebaseService.institutes;
}