import 'dart:async';

import 'package:flutter_banking/locator.dart';
import 'package:flutter_banking/model/account.dart';
import 'package:flutter_banking/model/institute.dart';
import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/services/contact_service.dart';
import 'package:flutter_banking/viewmodel/base_model.dart';

class AddContactModel extends BaseModel {
  final ContactService _contactService = locator<ContactService>();
  StreamSubscription _institutesSubscription;

  List<Institute> institutes;

  AddContactModel() {
    _institutesSubscription =
        _contactService.institutes.listen(_onInstitutesUpdated);
  }

  @override
  void dispose() {
    _institutesSubscription.cancel();
    super.dispose();
  }

  void _onInstitutesUpdated(List<Institute> institutes) {
    this.institutes = institutes;

    if (institutes == null) {
      setState(ViewState.Busy);
    } else {
      setState(institutes.isEmpty
          ? ViewState.NoDataAvailable
          : ViewState.DataFetched);
    }
  }

  Future<void> addContact(Account contact) {
    return _contactService.addContact(contact);
  }
}
