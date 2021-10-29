import 'dart:async';

import 'package:location/location.dart';
import 'package:mobile_tracker/datamodels/user_location.dart';

class LocationService {
  //Keep track of current Location
  late UserLocation _currentLocation;

  var location = Location();

  //Continuously emit location updates
  final StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  LocationService() {
    location.requestPermission().then((granted) {
      if (granted as bool) {
        location.onLocationChanged.listen((locationData) {
          _locationController.add(UserLocation(
              latitude: locationData.latitude,
              longitude: locationData.longitude,
              accuracy: locationData.accuracy,
              altitude: locationData.altitude,
              speed: locationData.speed,
              speedAccuracy: locationData.speedAccuracy,
              heading: locationData.heading,
              time: locationData.time,
              isMock: locationData.isMock));
        });
      }
    });
  }

  Stream<UserLocation> get locationStream => _locationController.stream;

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
          latitude: userLocation.latitude,
          longitude: userLocation.longitude,
          accuracy: userLocation.accuracy,
          altitude: userLocation.altitude,
          speed: userLocation.speed,
          speedAccuracy: userLocation.speedAccuracy,
          heading: userLocation.heading,
          time: userLocation.time,
          isMock: userLocation.isMock);
    } catch (e) {
      print('Could not get the location: $e');
    }

    return _currentLocation;
  }
}
