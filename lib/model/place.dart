import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final String documentID, name, type;
  final LatLng position;

  Place(
      {@required this.documentID,
      @required this.name,
      @required this.type,
      @required this.position});

  Place.fromSnapshot(DocumentSnapshot snapshot)
      : documentID = snapshot.documentID,
        name = snapshot['name'],
        type = snapshot['type'],
        position = LatLng(
            snapshot['position'].latitude, snapshot['position'].longitude);
}
