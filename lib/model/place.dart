import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final String id, name, type;
  final LatLng position;

  Place({@required this.id, this.name, @required this.type, @required this.position});
}
