import 'package:cloud_firestore/cloud_firestore.dart';

class Institute {
  final String documentID;
  final DocumentReference documentReference;
  final String name, bic, logo;

  Institute(
      {this.documentID,
      this.documentReference,
      this.name,
      this.bic,
      this.logo});

  Institute.fromSnapshot(DocumentSnapshot snapshot)
      : documentID = snapshot.documentID,
        documentReference = snapshot.reference,
        name = snapshot['name'],
        bic = snapshot['bic'],
        logo = snapshot['logo'];
}
