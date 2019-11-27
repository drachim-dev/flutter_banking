import 'dart:async';

import 'package:flutter_banking/locator.dart';
import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/services/contact_service.dart';
import 'package:flutter_banking/viewmodel/base_model.dart';

class ContactModel extends BaseModel {
  final ContactService _contactService = locator<ContactService>();
  StreamSubscription _contactsSubscription;

  List<Account> allContacts;
  List<Account> suggestedContacts;

  ContactModel() {
    _contactsSubscription = _contactService.contacts.listen(_onContactsUpdated);
  }

  @override
  void dispose() {
    _contactsSubscription.cancel();
    super.dispose();
  }

  void _onContactsUpdated(List<Account> contacts) {
    this.allContacts = contacts;
    this.suggestedContacts = contacts.take(1).toList();

    if (contacts == null) {
      setState(ViewState.Busy);
    } else {
      setState(
          contacts.isEmpty ? ViewState.NoDataAvailable : ViewState.DataFetched);
    }
  }
}
