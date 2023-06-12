import 'dart:ffi';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  //create variables
  RxBool isLoading = true.obs;
  final RxDouble Latitude = 0.00.obs;
  final RxDouble Longitude = 0.00.obs;

  RxBool checkLoading() => isLoading; //check with own code later
  RxDouble getLatitude() => Latitude;
  RxDouble getLongitude() => Longitude;

  @override
  void onInit() {
    if (isLoading.isTrue) {
      getLocation();
    }
    isLoading = false.obs;
    super.onInit();
  }

  getLocation() async {
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
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      Latitude.value = value.latitude;
      Longitude.value = value.longitude;
    });
  }
}
//24.08
