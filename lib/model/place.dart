import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final String documentID, name, type, address;
  final LatLng position;
  final bool hasATM;
  final bool hasCDM;

  Place(
      {@required this.documentID,
      @required this.name,
      @required this.type,
      @required this.address,
      @required this.position,
      @required this.hasATM,
      @required this.hasCDM});

  Place.fromSnapshot(DocumentSnapshot snapshot)
      : documentID = snapshot.documentID,
        name = snapshot['name'],
        type = snapshot['type'],
        address = snapshot['address'],
        position = LatLng(
            snapshot['position'].latitude, snapshot['position'].longitude),
        hasATM = snapshot['hasATM'],
        hasCDM = snapshot['hasCDM'];
}

class PlaceNew {
  final String documentID, name, description;
  final PlaceType type;
  final Address address;
  final LatLng position;

  PlaceNew(
      {this.documentID, this.name, this.description, this.type, this.address, this.position});
}


class PlaceType {

}

class Address {
  String country, city, street, streetNumber, postalCode;

  Address({this.country, this.city, this.street, this.streetNumber,
      this.postalCode});
}