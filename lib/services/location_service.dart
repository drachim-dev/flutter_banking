import 'dart:async';

import 'package:flutter_banking/model/user_location.dart';
import 'package:location/location.dart';

class LocationService {
  UserLocation _currentLocation;

  Location _location = Location();

  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();
  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationService() {
    _location.requestPermission().then((granted) {
      if (granted) {
        _location.onLocationChanged().listen((locationData) => {
              _locationController.add(UserLocation(
                  latitude: locationData.latitude,
                  longitude: locationData.longitude))
            });
      }
    });
  }

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await _location.getLocation();
      _currentLocation = UserLocation(
          latitude: userLocation.latitude, longitude: userLocation.longitude);
    } catch (e) {
      print('Could not get the location $e');
    }

    return _currentLocation;
  }
}
