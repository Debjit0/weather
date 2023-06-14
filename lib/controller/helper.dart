import 'package:geolocator/geolocator.dart';

class Helper {
  //create variables
  bool isLoading = true;

  Future getLocation() async {
    bool isServiceEnabled;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission locationPermission;
    //if permission is not enabled
    if (isServiceEnabled == false) {
      return Future.error("Locatiom is not enabled");
    }

    //status of location permission
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission is denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }

    //get current location
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
//24.08
