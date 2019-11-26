import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Institute {
  final String name, bic, logo;

  Institute({@required this.name, this.bic, this.logo});

  Institute.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        bic = snapshot['bic'],
        logo = snapshot['logo'];
}
