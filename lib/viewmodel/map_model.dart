import 'package:flutter_banking/locator.dart';
import 'package:flutter_banking/model/user_location.dart';
import 'package:flutter_banking/services/location_service.dart';
import 'package:flutter_banking/viewmodel/base_model.dart';

class MapModel extends BaseModel {
  final LocationService _locationService = locator<LocationService>();

  Stream<UserLocation> get locationStream => _locationService.locationStream;
}