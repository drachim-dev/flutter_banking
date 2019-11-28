import 'dart:async';

import 'package:flutter_banking/model/user_location.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';

class LocationService {
  Location _location = Location();
  UserLocation _currentLocation;

  StreamController<UserLocation> _locationController = BehaviorSubject();
  Stream<UserLocation> get locationStream => _locationController.stream;
  StreamSubscription _locationSubscription;

  LocationService() {
    _location.requestPermission().then((granted) {
      if (granted) {
        _locationSubscription = _location.onLocationChanged().listen((locationData) => {
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

  void dispose() {
    _locationSubscription.cancel();
  }
}