import 'package:flutter_banking/model/institute.dart';
import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/viewmodel/base_model.dart';

class ContactModel extends BaseModel {

  Future<List<Account>> getContacts() async {
    setState(ViewState.Busy);
    List<Account> contacts = [];
    contacts.add(Account(owner: 'Max Mustermann', institute: Institute(name: 'OLB'), number: 'DE12345678910900050100'));
    contacts.add(Account(owner: 'Max Mustermann', institute: Institute(name: 'Commerzbank'), number: 'DE12345678910900050100'));
    contacts.add(Account(owner: 'Max Mustermann', institute: Institute(name: 'Postbank'), number: 'DE12345678910900050100'));
    contacts.add(Account(owner: 'Wilma Bier', institute: Institute(name: 'Ing Diba'), number: 'DE98765433211009187123'));
    contacts.add(Account(owner: 'Wilma Bier', institute: Institute(name: 'Postbank'), number: 'DE98765433211009187123'));
    contacts.add(Account(owner: 'Wilma Bier', institute: Institute(name: 'Postbank'), number: 'DE98765433211009187123'));
    setState(ViewState.Idle);

    return contacts;
  }

  Future<List<Account>> getSuggestions() async {
    setState(ViewState.Busy);
    List<Account> contacts = [];
    contacts.add(Account(owner: 'Max Mustermann', institute: Institute(name: 'OLB'), number: 'DE12345678910900050100'));
    contacts.add(Account(owner: 'Wilma Bier', institute: Institute(name: 'OLB'), number: 'DE98765433211009187123'));
    contacts.add(Account(owner: 'Wilma Bier', institute: Institute(name: '1822 direkt'), number: 'DE98765433211009187123'));
    setState(ViewState.Idle);

    return contacts;
  }

}