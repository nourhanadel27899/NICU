// for get current location

import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<Position> getCurrentLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //for make if service enable or not
    if (!isServiceEnabled) {
      await Geolocator.requestPermission();
      //for get permission from user to get current location
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      //this for send current location to app
    );
  }
}
