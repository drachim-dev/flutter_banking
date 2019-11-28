import 'dart:async';

import 'package:flutter_banking/locator.dart';
import 'package:flutter_banking/model/place.dart';
import 'package:flutter_banking/model/user_location.dart';
import 'package:flutter_banking/model/viewstate.dart';
import 'package:flutter_banking/services/firebase_service.dart';
import 'package:flutter_banking/services/location_service.dart';
import 'package:flutter_banking/viewmodel/base_model.dart';

class MapModel extends BaseModel {
  final LocationService _locationService = locator<LocationService>();
  final FirebaseService _firebaseService = locator<FirebaseService>();

  StreamSubscription _placesSubscription;

  Stream<UserLocation> get locationStream => _locationService.locationStream;

  List<Place> places;

  MapModel() {
    _placesSubscription = _firebaseService.places.listen(_onPlacesUpdated);
  }

  @override
  void dispose() {
    _locationService.dispose();
    _placesSubscription.cancel();
    super.dispose();
  }

  void _onPlacesUpdated(List<Place> places) {
    this.places = places;

    if (places == null) {
      setState(ViewState.Busy);
    } else {
      setState(
          places.isEmpty ? ViewState.NoDataAvailable : ViewState.DataFetched);
    }
  }
}