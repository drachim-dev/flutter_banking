import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Branch {
  final String id, name, type;
  final LatLng position;

  Branch({@required this.id, this.name, @required this.type, @required this.position});
}
